class ChangeUserTournamentsToEntries < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_tournaments, :entries
  end
end
