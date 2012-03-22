class AddTimeToExamSession < ActiveRecord::Migration
  def change
    add_column :exam_sessions, :time, :time

  end
end
