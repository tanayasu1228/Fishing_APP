class HomesController < ApplicationController
  def top
    @tournaments = Tournament.first(4)
  end
end