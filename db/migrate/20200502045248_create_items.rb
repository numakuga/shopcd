class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :artist_id, index: true
      t.integer :label_id, index: true
      t.integer :genre_id, index: true
      t.string :title, null: false
      t.integer :price, null: false
      t.boolean :status, null: false, default: true
      t.string :jacket_image_id
      t.integer :stock, null: false
      t.datetime :release

      t.timestamps
    end
  end
end
