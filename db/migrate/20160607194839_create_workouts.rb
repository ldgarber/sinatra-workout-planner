class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :type
      t.decimal :length
      t.integer :user_id
    end
  end
end
