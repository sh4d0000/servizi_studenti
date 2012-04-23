class ChangeTypeDateColumn < ActiveRecord::Migration
  def up
    remove_column :exam_sessions, :time
    remove_column :exam_sessions, :date
    add_column    :exam_sessions, :date, :time
  end

  def down
    add_column :exam_sessions, :time, :time
    add_column :exam_sessions, :date, :date
    remove_column :exam_sessions, :date
  end
end
