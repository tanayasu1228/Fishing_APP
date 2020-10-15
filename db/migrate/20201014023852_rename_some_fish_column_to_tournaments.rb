class RenameSomeFishColumnToTournaments < ActiveRecord::Migration[6.0]
  def change
    rename_column :tournaments, :some_fish, :swap_limit
  end
end
