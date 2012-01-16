class SwitchResponsesToSegments < ActiveRecord::Migration
  def up
    add_column :survey_segments, :responses_count, :integer
    add_column :responses, :survey_segment_id, :integer
    SurveySegment.reset_column_information
    Response.reset_column_information
    Response.all.each do |response|
      survey = Survey.find(response.survey_id)
      segment = response.segment = survey.segments.first
      response.save!
      segment.responses_count ||= 0
      segment.responses_count += 1
      segment.save!
    end
    remove_column :surveys, :responses_count
    remove_column :responses, :survey_id
  end

  def down
    remove_column :responses, :survey_segment_id
    remove_column :survey_segments, :responses_count
    add_column :responses, :survey_id, :integer
    add_column :surveys, :responses_count, :integer
  end
end
