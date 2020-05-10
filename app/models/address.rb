class Address < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :postal_code
    validates :address
  end
end
