class RenameDiskIdColumnToSongs < ActiveRecord::Migration[5.2]
  def change
    rename_column :songs, :disk_id, :disc_id
  end
end
