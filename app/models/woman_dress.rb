class WomanDress < ApplicationRecord
	has_one :product, :dependent => :destroy, :as => :item
    has_one :user,  :through => :products
    has_many :images, :as => :image, dependent: :destroy
    has_many :comments, :as => :commentable, dependent: :destroy
	belongs_to :woman_category
	accepts_nested_attributes_for :images
    validates_associated :images
    has_many :clother_size_elements, :as => :clother
 	has_many :clother_sizes, :through => :clother_size_elements,  :as => :clother
    accepts_nested_attributes_for :clother_size_elements
    validates_associated :clother_size_elements

    has_many :comments, :as => :commentable
    
    has_many :likes, :as => :like
	has_many :liked_by, through: :likes, source: :user
end
