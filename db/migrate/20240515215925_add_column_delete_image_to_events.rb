class AddColumnDeleteImageToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :delete_image, :boolean, :default => false
  end
end
