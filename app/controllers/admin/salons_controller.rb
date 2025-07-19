class Admin::SalonsController < Admin::ApplicationController
  before_action :set_salon, only: [:show, :edit, :update, :destroy]
  
  def index
    @salons = Salon.all
    @salons = Salon.page(params[:page]).per(10)
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
      flash.now[:alert] = @salon.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @salon = Salon.find(params[:id])
  end

  def edit
    @salon = Salon.find(params[:id])
    @genres = Genre.all
  end

  def update
    @salon = Salon.find(params[:id])
    if @salon.update(salon_params)
      redirect_to admin_salon_path(@salon), notice: "サロン情報を更新しました。"
    else
      @genres = Genre.all
      flash.now[:alert] = @salon.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @salon = Salon.find(params[:id])
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
