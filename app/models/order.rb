class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_details, dependent: :destroy

  enum payment: [:cash, :bank, :cashondelivery]
end
