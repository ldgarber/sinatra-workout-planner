class FixExerciseWorkoutsWorkoutIdColumn < ActiveRecord::Migration
  def change
    rename_column :exercise_workouts, :workout_it, :workout_id
  end
end
