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
    @posts = @user.posts
    @post = Post.new
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
    params.require(:tournament).permit(:date, :fishing_ground, :fishing_style, :condition, :fish_name, :keeper_size, :some_fish, :comment)
  end
end