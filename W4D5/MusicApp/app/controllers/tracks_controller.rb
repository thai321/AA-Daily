class TracksController < ApplicationController
  before_action :set_track, only: [:edit, :show, :update, :destroy]
  before_action :require_user!

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to @track
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new, status: 422
    end
  end

  def new
    @album = Album.find(params[:album_id])
    @track = Track.new(album_id: @album.id)
    render :new
  end

  def edits
    render :edit
  end

  def show
    render :show
  end

  def update
    if @track.update(track_params)
      redirect_to @track
    else
      render :edit
    end
  end

  def destroy
    @track.destroy
    redirect_to album_url(@track.album_id)
  end

  private
  def track_params
    params.require(:track).permit(:title, :ord, :bonus, :album_id, :lyrics)
  end

  def set_track
    @track = Track.find(params[:id])
  end
end
