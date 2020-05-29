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
end
