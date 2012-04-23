class ChangeTypeInString < ActiveRecord::Migration
  def up
    remove_column :exam_sessions, :date
    add_column    :exam_sessions, :date, :string
  end

  def down
    remove_column :exam_sessions, :date
    add_column :exam_sessions, :date, :time
  end
end
