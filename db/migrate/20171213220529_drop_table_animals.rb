class DropTableAnimals < ActiveRecord::Migration[5.1]
  def change
    drop_table  :animals
  end
end
