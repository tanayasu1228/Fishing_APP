class EntriesController < ApplicationController
  def create
    @entry = current_user.entries.build(tournament_id: params[:tournament_id])
    @entry.save
    redirect_to tournaments_path
  end

  def destroy
    @entry = Entry.find_by(tournament_id: params[:tournament_id], user_id: current_user.id)
    @entry.destroy
    redirect_to tournaments_path
  end
end


