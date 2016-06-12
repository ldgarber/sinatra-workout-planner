class CreateExerciseItems < ActiveRecord::Migration
  def change
    create_table :exercise_items do |t|
      t.integer :exercise_id
      t.integer :item_id
    end
  end
end
