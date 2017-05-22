class AddUserIdToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :user_id, :integer
    add_column :phones, :user_id, :integer
  end
end