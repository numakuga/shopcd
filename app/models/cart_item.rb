class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  # 税込価格表示
  def tax_included
    (self.item.price * 1.10).round.to_s(:delimited)
  end
end
