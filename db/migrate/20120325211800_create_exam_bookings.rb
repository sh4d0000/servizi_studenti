class CreateExamBookings < ActiveRecord::Migration
  def change
    create_table :exam_bookings do |t|
      t.string :teaching
      t.date :date
      t.time :time
      t.string :classroom
      t.string :professor
      t.integer :booking_number
      t.text :notes
      t.string :delete_prenotation_url

      t.timestamps
    end
  end
end
