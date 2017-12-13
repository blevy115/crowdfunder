class AddCommentsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :projects, table_name: :comments
  end

end
