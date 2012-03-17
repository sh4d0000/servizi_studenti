class CreateStudyPlans < ActiveRecord::Migration
  def change
    create_table :study_plans do |t|
      t.references :teachings

      t.timestamps
    end
    add_index :study_plans, :teachings_id
  end
end
