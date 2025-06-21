class Public::ReviewsController < ApplicationController
  def new
    @post_review = PostReview.new
  end

  def create
    @post_review = PostReview.new(
      content: params[:content}
      user_id: @current_user.id
    )
    @post_review.save
    redirect_to action: 'index'
  end

  def show
    @post_review = PostReview.find_by(id: params[:id])
    @user = User.fnd_by(id: @post_review.user_id)
  end


  private
    def post_review_params #ストロングパラメータ
      params.require(:post_review).permit(:review_title, :review_text)
    end
end
