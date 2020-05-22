class ChangeDataIsDeletedToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :is_deleted, :datetime, default: "", null: true
  end

  def down
    change_column :users, :is_deleted, :boolean, default: false, null: false
  end
end
