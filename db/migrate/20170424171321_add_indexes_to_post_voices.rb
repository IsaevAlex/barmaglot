class AddIndexesToPostVoices < ActiveRecord::Migration[5.0]
   def change
    add_index :post_voices, :user_id
    add_index :post_voices, :post_id
    add_index :post_voices, [:user_id, :post_id], unique: true
  end
end
