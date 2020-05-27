class Item < ApplicationRecord
  belongs_to :artist
  belongs_to :label
  belongs_to :genre

  attachment :jacket_image

  # カートに入れるアイテム個数選択用の配列
  def stock_array
    self.stock == 0 ? ["売り切れ"]:[*1..self.stock]
  end
end
