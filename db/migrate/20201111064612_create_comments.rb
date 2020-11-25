class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :tournament_id
      t.text :body
      t.timestamps
    end
  end
end
