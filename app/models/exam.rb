class Exam < ActiveRecord::Base

  def ==( to_compare)

    self.code == to_compare.code
    
  end
end
