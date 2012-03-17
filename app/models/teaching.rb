class Teaching < ActiveRecord::Base
  has_and_belongs_to_many :study_plan

  def ==(to_compare)
    self.name == to_compare.name
  end
end
