class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def less_than_stock?
    piece <= item.stock
  end
end
