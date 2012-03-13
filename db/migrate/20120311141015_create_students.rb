class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :surname
      t.string :name
      t.string :gender
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :citizenship
      t.string :tax_code

      t.timestamps
    end
  end
end
