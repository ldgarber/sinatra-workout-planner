class Item < ActiveRecord::Base
  validates :name, presence: true
  has_many :exercise_items
  has_many :exercises, through: :exercise_items

  def workouts
    @@workouts = []
    self.exercises.each do |e|
      e.workouts.each do |w|
        @@workouts << w
      end
    end
    @@workouts
  end

end
