class Public::SalonsController < ApplicationController
  def index
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @salons = @genre.salons.page(params[:page])
    else
      @salons = Salon.all.page(params[:page])
    end
  end

  def show
    @salon = Salon.find(params[:id])
    @post_reviews = @salon.post_reviews
  end

  private
  def set_salon
    @salon = Salon.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "サロンが見つかりませんでした。"
  end
end
