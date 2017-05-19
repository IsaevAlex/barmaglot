class AddPriceToWomansAndMans < ActiveRecord::Migration[5.0]
  def change
    add_column :man_dresses, :price, :decimal
    add_column :man_dresses, :garant, :boolean
    add_column :man_dresses, :on_sale, :boolean
    add_column :woman_dresses, :price, :decimal
    add_column :woman_dresses, :garant, :boolean
    add_column :woman_dresses, :on_sale, :boolean
  end
end
