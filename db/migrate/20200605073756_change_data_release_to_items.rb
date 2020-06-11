class ChangeDataReleaseToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :release, :date
  end
end
