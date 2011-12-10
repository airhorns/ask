class AddFinishMessageToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :finish_message, :string
    Survey.all.each do |survey|
      survey.update_attributes(:finish_message => "Thanks, you're done!")
    end
  end
end
