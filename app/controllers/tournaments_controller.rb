class TournamentsController < ApplicationController
  before_action :tournament_params, only: [:confirm]


  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def confirm
    @tournament = Tournament.new(tournament_params)
    return if @tournament.valid?
    render :new
  end

  def back
    @tournament = Tournament.new(tournament_params)

    render :new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to tournaments_path notice: 'イベントを投稿しました。' 
    else
      render action: 'new' 
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

    private

  def tournament_params
    params.require(:tournament).permit(:date, :fishing_ground, :fishing_style, :condition, :fish_name, :keeper_size, :some_fish, :comment)
  end
end