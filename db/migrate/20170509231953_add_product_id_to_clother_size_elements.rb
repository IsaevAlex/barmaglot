class AddProductIdToClotherSizeElements < ActiveRecord::Migration[5.0]
  def change
    add_column :clother_size_elements, :product_id, :integer
  end
end
