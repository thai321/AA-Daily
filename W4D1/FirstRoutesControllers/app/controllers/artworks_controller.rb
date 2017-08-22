class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :update, :destroy]

  def index
    @artworks = Artwork.find_by(artist_id: params[:user_id])
    render json: @artworks
  end

  def show
    if @artwork
      render json: @artwork
    else
      render plain: "Can't find the artwork with id: #{params[:id]}", status: 404
    end
  end

  def update
    if @artwork.nil?
      render plain: "Can't find the artwork with id: #{params[:id]}", status: 404
    elsif @artwork.update(artwork_params)
      render json: @artwork
    else
      render json: @artwork.errors.full_messages, status: 422
    end
  end

  def create
    @artwork = Artwork.create(artwork_params)

    if @artwork.save
      render json: @artwork
    else
      render json: @artwork.errors.full_messages, status: 422
    end
  end

  def destroy
    @artwork.destroy
    render json @artwork
  end

  private
  def set_artwork
    @artwork = ArtWork.find_by(id: params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end
