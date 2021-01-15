class TournamentsController < ApplicationController
  before_action :tournament_params, only: [:confirm]

  def index
    @tournaments = Tournament.in_held_date_check
    @before_tournaments = Tournament.before_held_date_check
    @after_tournaments = Tournament.after_held_date_check
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
    keeper_size = @tournament.keeper_size
    s_limit = @tournament.swap_limit
    j_limit = @tournament.judging_limit
    main_rule = @tournament.main_rule
    if main_rule == "合計長さで勝負"
      @ranks = @tournament.posts.sort_rank_sumsize(keeper_size, s_limit, j_limit)
    elsif main_rule == "デカイもん勝ち"
      @ranks = @tournament.posts.sort_rank_maxsize(keeper_size, s_limit)
    elsif main_rule == "とにかく数を釣れ"
      @ranks = @tournament.posts.sort_rank_count(keeper_size)
    else
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
      redirect_to tournament_path, notice: "更新しました"
    else
      render :edit, alert: "入力に不備があります。"
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    entries = @tournament.entries.count
    if entries == 0 
      @tournament.delete
      redirect_to tournaments_path, notice: "削除しました"
    else
      redirect_to tournament_path, alert: "エントリー中のユーザーがいるため削除できません。"
    end
  end

    private

  def tournament_params
    params.require(:tournament).permit(:start_time, :end_time, :fishing_ground, :fishing_style, :main_rule, :fish_name, :keeper_size, :swap_limit, :judging_limit, :measure_rule, :comment, :designation, :image, :image_cache)
  end
end