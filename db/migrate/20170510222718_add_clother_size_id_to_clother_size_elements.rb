class AddClotherSizeIdToClotherSizeElements < ActiveRecord::Migration[5.0]
  def change
    add_column :clother_size_elements, :clother_size_id, :integer
  end
end
