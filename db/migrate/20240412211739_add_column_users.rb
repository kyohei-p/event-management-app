class AddColumnUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :phone_number, :string, null: false
    add_column :users, :self_introduction, :string
    add_column :users, :discard_at, :datetime
  end
end
