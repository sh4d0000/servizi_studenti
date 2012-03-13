class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :P_1XXD
      t.string :P_2XXI
      t.string :P_3XXC

      t.timestamps
    end
  end
end
