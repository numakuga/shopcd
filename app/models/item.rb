class Item < ApplicationRecord
  # リレーション
  belongs_to :artist
  belongs_to :label
  belongs_to :genre
  has_many   :cart_items
  has_many   :users,     through: :cart_items
  has_many   :discs,     dependent: :destroy
    has_many :favorites, dependent: :destroy

  # refile
  attachment :jacket_image

  attachment :jacket_image

  # カートに入れるアイテム個数選択用の配列
  def stock_array
    self.stock == 0 ? ["売り切れ"]:[*1..self.stock]
  end
  # 購入したアイテムの在庫を減らす
  def reduce_stock(piece)
    self.stock = stock - piece
    save!
  end
  # ファボしているか判定
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
