class RemoveNumberFromDisks < ActiveRecord::Migration[5.2]
  def change
    remove_column :disks, :number, :integer
    rename_table :disks, :discs
  end
end
