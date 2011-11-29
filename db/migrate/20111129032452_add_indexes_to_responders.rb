class AddIndexesToResponders < ActiveRecord::Migration
  def change
    add_index :responders, :phone_number, :name => "phone_number_ix"
    add_index :responses, :responder_id, :name => "responder_id_ix"
    add_index :responses, :survey_id, :name => "survey_id_ix"
    add_index :responses, [:survey_id, :responder_id]
    add_index :answers, :response_id, :name => "answer_response_id_ix"
  end
end
