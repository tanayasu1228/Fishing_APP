class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def my_show
    @user = User.find(current_user.id)
    @tournaments = @user.tournaments
    @entries = @user.entries
  end

  def show
    @user = User.find(params[:id])
    @tournaments = @user.tournaments
    @entries = @user.entries
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(current_user), notice: "更新しました。"
    else
      render :edit, alert: "入力に不備があります。"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :image, :nickname, :main_field, :main_target, :max_size, :comment)
  end
end
