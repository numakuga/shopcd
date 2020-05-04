class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :user_id, index: true
      t.integer :item_id, index: true
      t.integer :piece, null: false

      t.timestamps
    end
  end
end
