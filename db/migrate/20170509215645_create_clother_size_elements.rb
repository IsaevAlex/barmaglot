class CreateClotherSizeElements < ActiveRecord::Migration[5.0]
  def change
    create_table :clother_size_elements do |t|
      t.integer :clother_id
      t.string :clother_type

      t.timestamps
    end
  end
end
