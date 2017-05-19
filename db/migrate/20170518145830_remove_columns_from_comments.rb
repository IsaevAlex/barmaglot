class RemoveColumnsFromComments < ActiveRecord::Migration[5.0]
  def change
  	remove_column :comments, :comment_id, :text
  	remove_column :comments, :comment_type, :text
  end
end
