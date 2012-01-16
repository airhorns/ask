class RemovePhoneNumberFromSurveys < ActiveRecord::Migration
  def up
    Survey.all.each do |survey|
      segment = survey.segments.build({:phone_number => survey.phone_number, :name => "Default"})
      segment.save!
    end
    remove_column :surveys, :phone_number
  end

  def down
    add_column :surveys, :phone_number, :string
  end
end
