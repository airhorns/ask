class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :type
      t.integer :survey_id
      t.string :options

      t.timestamps
    end
  end
end
