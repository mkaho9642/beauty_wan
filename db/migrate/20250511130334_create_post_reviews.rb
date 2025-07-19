class CreatePostReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :post_reviews do |t|
      t.string :review_title
      t.text :review_text
      t.integer :user_id
      t.integer :salon_id
      t.integer :comment_id
      t.timestamps
    end
  end
end
