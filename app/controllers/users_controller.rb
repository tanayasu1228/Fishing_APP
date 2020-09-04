class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def my_show
    @user = User.find(current.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  end
