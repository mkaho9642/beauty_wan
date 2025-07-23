class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :confirm, :quit]

  def mypage
    @user = User.find(params[:id])
    render 'mypage'
  end

  def show
    @user = User.find(params[:id])
    render 'user'
  end

  def index
    @user = User.find(params[:id])
    @favorited_salons = @user.favoriting_salons
    render 'bookmark'
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "他のユーザーの情報を編集することはできません。"
    end
    render 'edit'
  end

  def bookmark
    @user = User.find(params[:id])
    @favorited_salons = @user.favoriting_salons.page(params[:page]).per(10)
  end

  def update
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "他のユーザーの情報を編集することはできません。"
      return
    end
    permitted_params = user_params.except(:password, :password_confirmation)
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '登録情報を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def confirm
    @user = current_user
    render 'confirm'
  end
  
  def quit
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path, notice: '退会しました。'
  end

  private
  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :profile_image)
  end

  def user_state
    @user = user.find_by(email: params[:user][:email])
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])
  end
end
