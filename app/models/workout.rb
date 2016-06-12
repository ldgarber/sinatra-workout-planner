class Workout < ActiveRecord::Base
  validates :name, presence: true
  has_many :exercise_workouts
  has_many :exercises, through: :exercise_workouts
  belongs_to :user

  def items    
    @@items = []
    self.exercises.each do |e| 
      e.items.each do |i|
        @@items <<  i
      end
    end
    @@items
  end
end
