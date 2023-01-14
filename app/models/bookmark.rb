class Bookmark < ApplicationRecord
  validates :customer_id, uniqueness: { scope: :post_id }
end
