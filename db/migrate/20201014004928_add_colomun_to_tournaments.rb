class AddColomunToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :sub_rule, :string
    add_column :tournaments, :judging_limit, :string
    add_column :tournaments, :measure_rule, :string
    add_column :tournaments, :designation, :string
    add_column :tournaments, :image, :string
  end
end
