class CreateIsees < ActiveRecord::Migration
  def change
    create_table :isees do |t|
      t.string :student_code
      t.string :name
      t.string :surname
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :tax_code
      t.float :value_scale_equivalence
      t.float :ise
      t.float :isee

      t.timestamps
    end
  end
end
