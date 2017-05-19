class RemoveColumnsFromWomansAndMans < ActiveRecord::Migration[5.0]
  def change
  	remove_column :woman_dresses, :name, :string
  	remove_column :woman_dresses, :price, :decimal
  	remove_column :woman_dresses, :description, :text
  	remove_column :man_dresses, :name, :string
  	remove_column :man_dresses, :price, :decimal
  	remove_column :man_dresses, :description, :text
    
  end
end
