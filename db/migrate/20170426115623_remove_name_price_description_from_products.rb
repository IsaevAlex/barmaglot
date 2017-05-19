class RemoveNamePriceDescriptionFromProducts < ActiveRecord::Migration[5.0]
  def change
  	remove_column :products, :name, :string
  	remove_column :products, :description, :text
  	remove_column :products, :price, :decimal
  end
end
