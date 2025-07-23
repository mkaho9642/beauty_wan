class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @salon = Salon.find(params[:salon_id]) if params[:salon_id].present?
    @post_review = PostReview.new(salon_id: @salon.id)
  end

  def create
    @post_review = current_user.post_reviews.new(post_review_params)
    if @post_review.save
      flash[:notice] = "レビューを投稿しました。"
      redirect_to salon_path(@post_review.salon)
    else
      @salon = Salon.find(@post_review.salon_id) if @post_review.salon_id.present?
      flash.now[:alert] = "レビューの投稿に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post_review = PostReview.find_by(id: params[:id])
    unless @post_review
      flash[:alert] = "指定されたレビューが見つかりませんでした。"
      redirect_to root_path
    end
    @user = @post_review.user
    @salon = @post_review.salon
  end

  private
    def post_review_params
      params.require(:post_review).permit(:salon_id, :review_title, :review_text, :raty)
    end
end
