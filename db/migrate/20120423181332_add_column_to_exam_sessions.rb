class AddColumnToExamSessions < ActiveRecord::Migration
  def change
    add_column :exam_sessions, :date, :string
  end
end
