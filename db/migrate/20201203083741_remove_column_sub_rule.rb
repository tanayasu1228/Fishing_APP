class RemoveColumnSubRule < ActiveRecord::Migration[6.0]
  def up
    remove_column :tournaments, :sub_rule
      end
end
