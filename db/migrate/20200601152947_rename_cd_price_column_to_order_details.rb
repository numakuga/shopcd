class RenameCdPriceColumnToOrderDetails < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_details, :cd_price, :price
    rename_column :order_details, :cd_amount, :piece
  end
end
