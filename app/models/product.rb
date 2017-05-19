class Product < ApplicationRecord
	scope :womans, -> {
  		where(:item_type => "WomanDress") 
	} 
	scope :mans, -> {
  		where(:item_type => "ManDress") 
	}   
	belongs_to :user
    belongs_to :item, :polymorphic => true
    has_many :likes, :as => :like

    scope :man_dress, -> { where("item_type = ?" ,"ManDress") }
    scope :woman_dress, -> { where("item_type = ?" ,"WomanDress") }
	
	def self.from_users_followed_by(user)
      followed_user_ids = "SELECT followed_id FROM relationships
                           WHERE follower_id = :user_id"
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
            user_id: user.id)
    end    
end
