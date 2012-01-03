class AddSubjectToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :subject_id, :integer
    add_column :alerts, :subject_type, :string
    remove_column :alerts, :survey_id
  end
end
