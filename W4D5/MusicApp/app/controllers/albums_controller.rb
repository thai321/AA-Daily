class AlbumsController < ApplicationController
  before_action :set_album, only: [:edit, :show, :update, :destroy]
  before_action :require_user!

  def create
    @album = Album.new(album_params)
    # byebug
    if @album.save
      redirect_to @album
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new, status: 422
    end
  end

  def new
    @band = Band.find(params[:band_id])
    @album = Album.new(band_id: @band.id)
    render :new
  end

  def edits
    render :edit
  end

  def show
    render :show
  end

  def update
    if @album.update(album_params)
      redirect_to @album
    else
      render :edit
    end
  end

  def destroy
    @album.destroy
    redirect_to band_url(@album.band_id)
  end

  private
  def album_params
    params.require(:album).permit(:title, :year, :live, :band_id)
  end

  def set_album
    @album = Album.find(params[:id])
  end
end
