class AddDescriptionToExercises < ActiveRecord::Migration
  def change
    add_column(:exercises, :description, :string)
  end
end
