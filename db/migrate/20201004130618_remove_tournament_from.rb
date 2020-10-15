class RemoveTournamentFrom < ActiveRecord::Migration[6.0]
  def change
    remove_column :tournaments, :date, :date
  end
end
