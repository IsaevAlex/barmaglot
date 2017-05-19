class AddNameToManDresses < ActiveRecord::Migration[5.0]
  def change
    add_column :man_dresses, :name, :string
  end
end
