class AddNameToWomanDresses < ActiveRecord::Migration[5.0]
  def change
    add_column :woman_dresses, :name, :string
  end
end
