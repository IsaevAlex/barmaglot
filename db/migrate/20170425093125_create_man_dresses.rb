class CreateManDresses < ActiveRecord::Migration[5.0]
  def change
    create_table :man_dresses do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :man_category_id

      t.timestamps
    end
  end
end
