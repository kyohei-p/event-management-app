class AddColumnDeleteImageToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :delete_image, :boolean, :default => false
  end
end
