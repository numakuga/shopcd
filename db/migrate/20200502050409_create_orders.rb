class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false, index: true
      t.integer :total_price, null: false
      t.integer :delivery_cost, null: false
      t.integer :payment, null: false
      t.string :postal_code, null: false
      t.integer :status, null: false, default: 0
      t.string :address, null: false

      t.timestamps
    end
  end
end
