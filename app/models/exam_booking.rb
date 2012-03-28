class ExamBooking < ActiveRecord::Base
  def ==(to_compare)

    self.teaching == to_compare.teaching && self.date == to_compare.date && self.time == to_compare.time


  end
end
