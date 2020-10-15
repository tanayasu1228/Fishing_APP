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
  end

  def back
    @tournament = Tournament.new(tournament_params)
    render :new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user_id = current_user.id
    if @tournament.save
      redirect_to tournaments_path notice: 'イベントを投稿しました。' 
    else
      render action: 'new' 
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @user = @tournament.user
    @post = Post.new
    @ranks = @tournament.posts.sort_rank
  end


  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
      redirect_to tournament_path, notice: "更新しました。"
    else
      flash.now[:alert] = "入力に不備があります。"
      render :edit
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.delete
    redirect_to tournaments_path, notice: "削除しました。"
  end

    private

  def tournament_params
    params.require(:tournament).permit(:start_time, :end_time, :fishing_ground, :fishing_style, :main_rule, :fish_name, :keeper_size, :swap_limit, :judging_limit, :measure_rule, :comment, sub_rule: [])
  end
end