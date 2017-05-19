class CreateClotherSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :clother_sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
