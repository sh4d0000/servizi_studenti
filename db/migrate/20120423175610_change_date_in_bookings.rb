class ChangeDateInBookings < ActiveRecord::Migration
  def up
    remove_column :exam_bookings, :date
    remove_column :exam_bookings, :time
    add_column    :exam_bookings, :date, :string
  end

  def down
    remove_column :exam_bookings, :date
    add_column :exam_bookings, :date, :date
    add_column :exam_bookings, :time, :time
  end
end
