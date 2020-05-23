class Item < ApplicationRecord
  # リレーション
  belongs_to :artist
  belongs_to :label
  belongs_to :genre
  has_many   :cart_items
  has_many   :users, through: :cart_items
  has_many   :discs, dependent: :destroy

  # refile
  attachment :jacket_image

  # カートに入れるアイテム個数選択用の配列
  def stock_array
    self.stock == 0 ? ["売り切れ"]:[*1..self.stock]
  end
end
