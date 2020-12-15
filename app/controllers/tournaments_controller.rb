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
    # binding.pry
    if @tournament.save!
      redirect_to tournaments_path notice: "トーナメントが作成されました" 
    else
      render action: 'new' 
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    # @tournament = Tournament.find(39)
    @user = @tournament.user
    @post = Post.new
    # @ranks = @tournament.posts.sort_rank

    keeper_size = @tournament.keeper_size
    s_limit = @tournament.swap_limit
    j_limit = @tournament.judging_limit
    main_rule = @tournament.main_rule
    

    # posts = @tournament.posts.includes(:user)
    
    if main_rule == "合計長さで勝負"
      # @ranks = @tournament.posts.sort_rank
      @ranks = @tournament.posts.sort_rank_sumsize(keeper_size, s_limit, j_limit)
    elsif main_rule == "デカイもん勝ち"
      @ranks = @tournament.posts.sort_rank_maxsize(keeper_size, s_limit)
    elsif main_rule == "とにかく数を釣れ"
      @ranks = @tournament.posts.sort_rank_count(keeper_size)

      # @maxsize_ranks = @tournament.posts.includes(:user)

      # sort_size_users = @maxsize_ranks.where(user_id: "users.id").group("users.id", "users.nickname").order("posts.created_at ASC").select("*")

      # OK
      # sort_size_users = @maxsize_ranks.group("users.id").select("users.nickname")
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
      flash.now[:alert] = "入力に不備があります。"
      render :edit
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