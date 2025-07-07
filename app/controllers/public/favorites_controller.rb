class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @salon = Salon.find(params[:salon_id])
    @favorite = current_user.favorites.new(salon_id: @salon.id)

    if @favorite.save
      redirect_back fallback_location: root_path, notice: 'サロンをブックマークしました。'
    else
      redirect_back fallback_location: root_path, alert: 'サロンのブックマークに失敗しました。'
    end
  end

  def destroy
    @salon = Salon.find(params[:salon_id])
    @favorite = current_user.favorites.find_by(salon_id: @salon.id)

    if @favorite.destroy
      redirect_back fallback_location: root_path, notice: 'サロンのブックマークを解除しました。'
    else
      redirect_back fallback_location: root_path, alert: 'サロンのブックマーク解除に失敗しました。'
    end
  end
end
