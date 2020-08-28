class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.date :date
      t.string :fishing_ground
      t.string :fishing_style
      t.string :condition
      t.string :fish_name
      t.string :keeper_size
      t.string :some_fish
      t.text :comment
      t.timestamps
    end
  end
end
