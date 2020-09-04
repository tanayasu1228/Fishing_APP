class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :image, :string
    add_column :users, :main_field, :string
    add_column :users, :main_targe, :string
    add_column :users, :max_size, :string
    add_column :users, :comment, :text
  end
end
