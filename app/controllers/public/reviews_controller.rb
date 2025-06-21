class Public::ReviewsController < ApplicationController
  def new
    @post_review = PostReview.new
  end

  def create
    @post_review = PostReview.new(post_params)
    @post_review.save
    redirect_to action: 'index'
  end

  def show
  end


  private
    def post_review_params #ストロングパラメータ
      params.require(:post_review).permit(:review_title, :review_text)
    end
end
