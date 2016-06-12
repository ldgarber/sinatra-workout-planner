class ExerciseItem < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :item
end
