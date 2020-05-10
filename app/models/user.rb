class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses,  dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :items,      through: :cart_items, dependent: :destroy
  has_many :orders,     dependent: :destroy

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :first_kana
    validates :last_kana
    validates :postal_code, length: {is: 7}
    validates :phone
  end

end
