class User < ApplicationRecord
  
  has_many :products, :dependent => :destroy, :foreign_key => "user_id", :class_name => "Product"
  has_many :woman_dresses, :source => :item, :through => :products, :source_type => "WomanDress", :class_name => "WomanDress"
  has_many :man_dresses, :source => :item, :through => :products, :source_type => "ManDress", :class_name => "ManDress"
  

  has_many :posts
  has_one :image, :as => :image, dependent: :destroy 
  has_many :likes
  has_many :conversations, :foreign_key => :sender_id
  has_many :users
  
  has_many :sender_conversations, foreign_key: 'sender_id', class_name: 'Conversation'
  has_many :recipient_conversations, foreign_key: 'recipient_id', class_name: 'Conversation'

  has_many :post_voices  
  has_many :voices, through: :post_voices, source: :post

  has_many :post_comments
  has_many :comments

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_one :location
  has_many :phones
  accepts_nested_attributes_for :phones
  validates_associated :phones

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Получить identity пользователя, если он уже существует
    identity = Identity.find_for_oauth(auth)

    # Если signed_in_resource предоставлен оно всегда переписывает существующего пользователя
    # что бы identity не была закрыта случайно созданным аккаунтом.
    # Заметьте, что это может оставить зомби-аккаунты (без прикрепленной identity)
    # которые позже могут быть удалены
    user = signed_in_resource ? signed_in_resource : identity.user

    # Создать пользователя, если нужно
    if user.nil?

      # Получить email пользователя, если его предоставляет провайдер
      # Если email не был предоставлен мы даем пользователю временный и просим
      # пользователя установить и подтвердить новый в следующим шаге через UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Создать пользователя, если это новая запись
      if user.nil?
        user = User.new(
          name: auth.info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20],
          remote_avatar: auth.info.image
        )

        user.skip_confirmation!
        user.save!
      end
    end

    # Связать identity с пользователем, если необходимо
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  
  def feed
    Post.from_users_followed_by(self)
  end

  def product_feed
    Product.from_users_followed_by(self)
  end




end
