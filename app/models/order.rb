class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_details, dependent: :destroy

  enum payment: [:creditcard, :bank, :cashondelivery]
  enum status: [:notaccepted, :accepted, :preparation, :shipped, :delivered]
end
