class Exercise < ActiveRecord::Base
  validates :name, presence: true
  has_many :exercise_workouts  
  has_many :workouts, through: :exercise_workouts
  has_many :exercise_items
  has_many :items, through: :exercise_items
end
