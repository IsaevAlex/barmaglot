class Post < ApplicationRecord
	  belongs_to :user
	
	  has_many :post_images, dependent: :destroy
	  accepts_nested_attributes_for :post_images
    validates_associated :post_images

    has_many :post_voices
    has_many :voiced_by, through: :post_voices, source: :user

    has_many :post_comments
    validates :name, presence: true
    validates :description, presence: true

    def self.from_users_followed_by(user)
      followed_user_ids = "SELECT followed_id FROM relationships
                           WHERE follower_id = :user_id"
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
            user_id: user.id)
    end
end
