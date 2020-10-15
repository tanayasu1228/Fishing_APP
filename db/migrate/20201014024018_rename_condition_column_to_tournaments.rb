class RenameConditionColumnToTournaments < ActiveRecord::Migration[6.0]
  def change
    rename_column :tournaments, :condition, :main_rule
  end
end
