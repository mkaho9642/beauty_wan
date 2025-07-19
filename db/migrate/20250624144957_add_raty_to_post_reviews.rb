class AddRatyToPostReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :post_reviews, :raty, :integer
  end
end
