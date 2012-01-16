class CreateSurveySegments < ActiveRecord::Migration
  def change
    create_table :survey_segments do |t|
      t.string :phone_number
      t.integer :survey_id
      t.string :name

      t.timestamps
    end
  end
end
