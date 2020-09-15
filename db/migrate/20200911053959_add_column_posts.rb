class AddColumnPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :tournament_id, :integer
  end
end
