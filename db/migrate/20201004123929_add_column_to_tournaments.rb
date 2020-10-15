class AddColumnToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :start_time, :datetime
    add_column :tournaments, :end_time, :datetime
  end
end
