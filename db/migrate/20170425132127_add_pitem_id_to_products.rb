class AddPitemIdToProducts < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :item_id, :integer
  	add_column :products, :item_type, :string
  end
end
