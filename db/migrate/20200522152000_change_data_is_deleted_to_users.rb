class ChangeDataIsDeletedToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :is_deleted, :datetime, from: false, to: nil
  end
end
