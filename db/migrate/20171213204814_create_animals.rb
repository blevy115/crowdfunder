class CreateAnimals < ActiveRecord::Migration[5.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :desc
      t.integer :lifespan

      t.timestamps
    end
  end
end
