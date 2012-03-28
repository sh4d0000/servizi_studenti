class AddPrenotationUrlToExamSession < ActiveRecord::Migration
  def change
    add_column :exam_sessions, :prenotation_url, :string

  end
end
