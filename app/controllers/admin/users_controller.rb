class Admin::UsersController < Admin::ApplicationController
  before_action :authenticate_admin!
  
  def index
      @users = User.all
      @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    is_active_param_value = params[:user].delete(:is_active)
    update_successful = @user.update(user_params)
    if is_active_param_value.present?
      new_is_active = (is_active_param_value == 'true')
      if @user.is_active != new_is_active
        if @user.update_column(:is_active, new_is_active)
          @user.touch
        else
          update_successful = false
        end
      end
    end

    if update_successful
      redirect_to admin_user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :nickname)
  end
end
