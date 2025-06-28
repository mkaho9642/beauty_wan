class PostReview < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :salon
  has_many :post_comments, class_name: 'PostComment', foreign_key: 'review_id', dependent: :destroy
  validates :raty, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :review_title, presence: true, length: { maximum: 100 }
  validates :review_text, presence: true, length: { maximum: 500 }
end
