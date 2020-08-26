class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :title
      t.date :date
      t.string :fishing_ground
      t.string :fish_name
      t.string :fish_size
      t.string :fish_image
      t.text :comment
      t.timestamps
    end
  end
end
