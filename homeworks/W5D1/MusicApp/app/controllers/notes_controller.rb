class NotesController < ApplicationController
  before_action :require_user!
  before_action :set_note, only: [:destroy]

  def create
    note = current_user.notes.new(note_params)
    note.save
    flash.now[:errors] = note.errors.full_messages
    redirect_to note.track
  end

  def destroy
    if @note.user_id != current_user.id
      render text: "You are not authorized to delete this note", status: 404
    else
      @note.destroy
      redirect_to @note.track
    end
  end

  private
  def set_note
    @note = current_user.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:content, :track_id, :user_id)
  end
end
