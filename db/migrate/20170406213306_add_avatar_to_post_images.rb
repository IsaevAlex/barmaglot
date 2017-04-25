class AddAvatarToPostImages < ActiveRecord::Migration[5.0]
  def up
    add_attachment :post_images, :avatar
  end
 
  def down
    remove_attachment :post_images, :avatar
  end
end
