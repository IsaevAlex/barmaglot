class CreateWomanDresses < ActiveRecord::Migration[5.0]
  def change
    create_table :woman_dresses do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :woman_category_id

      t.timestamps
    end
  end
end
