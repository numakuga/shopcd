class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # paranoia
  acts_as_paranoid column: :is_deleted

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # リレーション
  has_many :addresses,  dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :items,      through: :cart_items
  has_many :orders,     dependent: :destroy
  has_many :favorites,  dependent: :destroy

  # バリデーション
  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :first_kana
    validates :last_kana
    validates :postal_code, length: {is: 7}
    validates :phone
  end

  # メソッド
  def full_name
    "#{first_name} #{last_name}"
  end

  def kana_full_name
    "#{first_kana} #{last_kana}"
  end

  def cart_total_price
    total_price = 0
    cart_items.each do |cart_item|
      # round = 小数点以下切り捨て
      total_price += (cart_item.piece * cart_item.item.price * 1.08).round
    end
    return total_price
  end

  def cart_total_piece
    total_piece = 0
    cart_items.each do |cart_item|
      total_piece += cart_item.piece
    end
    return total_piece
  end
end
