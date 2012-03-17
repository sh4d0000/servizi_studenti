class StudyPlan < ActiveRecord::Base
  has_and_belongs_to_many :teachings
end
