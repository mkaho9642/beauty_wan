class Public::SalonsController < ApplicationController
  def show
    @salon = Salon.find(params[:id])
    @post_reviews = @salon.review_id
  end

  private
  def set_salon
    @salon = Salon.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "サロンが見つかりませんでした。"
  end
end
