class TournamentsController < ApplicationController
  before_action :tournament_params, only: [:confirm]

  SUB_RULE = ["ウェーディング有り", "膝までの入水OK", "船全般OK"]

  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
    @sub_list = SUB_RULE
  end

  def confirm
    @tournament = Tournament.new(tournament_params)
    return if @tournament.valid?
    @sub_list = SUB_RULE
  end

  def back
    @tournament = Tournament.new(tournament_params)
    render :new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user_id = current_user.id
    # binding.pry
    if @tournament.save!
      redirect_to tournaments_path notice: "トーナメントが作成されました" 
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
      redirect_to tournament_path, notice: "更新しました"
    else
      flash.now[:alert] = "入力に不備があります。"
      render :edit
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.delete
    redirect_to tournaments_path, notice: "削除しました"
  end

    private

  def tournament_params
    params.require(:tournament).permit(:start_time, :end_time, :fishing_ground, :fishing_style, :main_rule, :fish_name, :keeper_size, :swap_limit, :judging_limit, :measure_rule, :comment, :designation, :image, :image_cache, :sub_rule)
  end
end