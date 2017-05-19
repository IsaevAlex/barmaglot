class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :like_id
      t.string :like_type
      t.integer :user_id

      t.timestamps

      
    end
  end
end
