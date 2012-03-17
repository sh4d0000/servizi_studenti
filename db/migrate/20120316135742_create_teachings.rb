class CreateTeachings < ActiveRecord::Migration
  def change
    create_table :teachings do |t|
      t.integer :program_year
      t.string :name
      t.string :outcome
      t.integer :cfu
      t.string :taf
      t.string :ssd

      t.timestamps
    end
  end
end
