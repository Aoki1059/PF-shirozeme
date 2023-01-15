class Bookmark < ApplicationRecord
  belongs_to :post
  validates :customer_id, uniqueness: { scope: :post_id }
end
