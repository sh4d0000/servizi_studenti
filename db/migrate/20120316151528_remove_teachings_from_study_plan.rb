class RemoveTeachingsFromStudyPlan < ActiveRecord::Migration
  def up
    remove_column :study_plans, :teachings_id
      end

  def down
    add_column :study_plans, :teachings_id, :references
  end
end
