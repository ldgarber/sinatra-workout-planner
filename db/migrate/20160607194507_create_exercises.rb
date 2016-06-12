class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :sets
      t.integer :reps
      t.decimal :time
      t.boolean :weighted
      t.integer :user_id
    end
  end
end
