class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_review, class_name: 'PostReview', foreign_key: 'review_id'
  validates :comment_text, presence: true, length: { maximum: 200 }
end
