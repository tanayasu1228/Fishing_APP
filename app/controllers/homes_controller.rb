class HomesController < ApplicationController
  def top
    @tournaments = Tournament.before_held_date_check.first(4)
  end
end