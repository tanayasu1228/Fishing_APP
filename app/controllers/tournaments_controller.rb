class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new
  end
end