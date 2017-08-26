class BandsController < ApplicationController
  before_action :set_band, only: [:edit, :show, :update, :destroy]
  before_action :require_user!

  def index
    @bands = Band.all
    render :index
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new, status: 422
    end
  end

  def new
    @band = Band.new
  end

  def edit
    render :edit
  end

  def show
    render :show
  end

  def update
    if @band.update(band_params)
      redirect_to @band
    else
      render :edit
    end
  end

  def destroy
    @band.destroy
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

  def set_band
    @band = Band.find(params[:id])
  end
end
