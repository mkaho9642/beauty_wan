class Admin::SalonsController < ApplicationController
  layout 'admin'
  before_action :set_salon, only: [:show, :edit, :update, :destroy]
  
  def index
    @salons = Salon.all
  end

  def new
    @salon = Salon.new
    @genres = Genre.all
  end

  def create
    @salon = Salon.new(salon_params)
    if @salon.save
      redirect_to admin_salon_path(@salon), notice: "サロンを登録しました"
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
  end

  def edit
    @genres = Genre.all
  end

  def update
    if @salon.update(salon_params)
      redirect_to admin_salon_path(@salon), notice: "サロン情報を更新しました。"
    else
      @genres = Genre.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @salon.destroy
    redirect_to admin_salons_path, notice: "サロンを削除しました。"
  end

  private

    def set_salon
      @salon = Salon.find(params[:id])
    end

    def salon_params
      params.require(:salon).permit(:name, :introduction, :image, :genre_id)
    end
end
