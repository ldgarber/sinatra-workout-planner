class CreateWorkoutItems < ActiveRecord::Migration
  def change
    create_table :workout_items do |t|
      t.integer :workout_id
      t.integer :item_id
    end
  end
end
