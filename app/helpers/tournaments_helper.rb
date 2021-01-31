module TournamentsHelper
  def choose_new_or_show
    binding.pry
    if action_name == 'new' || action_name == 'confirm'
      confirm_tournaments_path
    elsif action_name == 'show'
      tournament_path
    end
  end
end