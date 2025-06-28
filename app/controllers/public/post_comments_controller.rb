class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post_review = PostReview.find(params[:review_id])
    @post_comment = current_user.post_comments.new(post_comment_params.merge(review_id: @post_review.id))

    if @post_comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to review_path(@post_review)
    else
      flash.now[:alert] = "コメントの投稿に失敗しました。"
      @user = @post_review.user
      @salon = @post_review.salon
      @new_comment = @post_comment
      render 'public/reviews/show', status: :unprocessable_entity
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_review = @post_comment.post_review
    if @post_comment.user == current_user
      @post_comment.destroy
      flash[:notice] = "コメントを削除しました。"
    else
      flash[:alert] = "コメントを削除する権限がありません。"
    end
    redirect_to review_path(@post_review)
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment_text)
    end
end
