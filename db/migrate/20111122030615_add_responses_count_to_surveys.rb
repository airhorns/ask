class AddResponsesCountToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :responses_count, :integer
  end
end
