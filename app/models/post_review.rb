class PostReview < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :salon
  validates :review_title, presence: true, length: { maximum: 100 }
  validates :review_text, presence: true, length: { maximum: 500 }
end
