class AddingColumnToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :date_posted, :datetime
    add_column :comments, :reviews, :text
  end
end
