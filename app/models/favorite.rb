class Favorite < ApplicationRecord
  # リレーション
  belongs_to :user
  belongs_to :item
end
