class AddIndexesToLikes < ActiveRecord::Migration[5.0]
  def change
  	  add_index :likes, :user_id
      add_index :likes, :like_id
      add_index :likes, [:user_id, :like_id], unique: true
  end
end
