class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :code
      t.string :academic_year
      t.text :description
      t.float :amount
      t.date :date

      t.timestamps
    end
  end
end
