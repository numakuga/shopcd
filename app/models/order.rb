class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_details, dependent: :destroy

  enum payment: [:クレジットカード, :銀行, :代引き]
end
