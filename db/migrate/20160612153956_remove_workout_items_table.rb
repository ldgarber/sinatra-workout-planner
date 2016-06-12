class RemoveWorkoutItemsTable < ActiveRecord::Migration
  def change
    drop_table(:workout_items)
  end
end
