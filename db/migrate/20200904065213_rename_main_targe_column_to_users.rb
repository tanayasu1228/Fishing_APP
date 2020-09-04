class RenameMainTargeColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :main_targe, :main_target
  end
end
