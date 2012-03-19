class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :name
      t.date :date
      t.string :code
      t.string :outcome

      t.timestamps
    end
  end
end
