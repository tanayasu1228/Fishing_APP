class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :fish_image
      t.string :fish_name
      t.float :catch_size
      t.float :weight
      t.string :lure
      t.string :rod
      t.string :reel
      t.string :line
      t.string :range
      t.integer :user_id

      t.timestamps
    end
  end
end
