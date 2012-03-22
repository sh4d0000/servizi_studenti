class CreateExamSessions < ActiveRecord::Migration
  def change
    create_table :exam_sessions do |t|
      t.string :teaching
      t.string :course
      t.string :address
      t.integer :cfu
      t.string :ssd
      t.date :date
      t.string :prenotation_range
      t.string :classroom
      t.string :professor
      t.text :notes

      t.timestamps
    end
  end
end
