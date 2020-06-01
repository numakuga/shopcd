class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  # 税込価格表示
  def tax_included
    (self.price * 1.10).round.to_s(:delimited)
  end
end
