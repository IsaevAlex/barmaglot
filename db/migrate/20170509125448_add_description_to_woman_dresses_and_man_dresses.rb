class AddDescriptionToWomanDressesAndManDresses < ActiveRecord::Migration[5.0]
  def change
    add_column :woman_dresses, :description, :text
    add_column :man_dresses, :description, :text
  end
end
