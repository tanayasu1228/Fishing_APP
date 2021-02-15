class HomesController < ApplicationController
  DispCount = 4
  def top
    @tournaments = Tournament.before_held_date_check.first(DispCount)
  end
end