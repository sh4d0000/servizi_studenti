class Payment < ActiveRecord::Base

  def ==(to_compare)

    self.academic_year == to_compare.academic_year && self.code == to_compare.code 

  end

end
