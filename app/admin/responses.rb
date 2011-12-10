ActiveAdmin.register Response do

  index do
    column :responder do |response|
      link_to response.responder.phone_number, admin_responder_path(response.responder)
    end
    column :survey do |response|
      link_to response.survey.name, admin_survey_path(response.survey)
    end
    column :answers do |response|
      "#{response.answers.count} / #{response.survey.questions.count}"
    end
    default_actions
  end

  show do
    render 'show'
  end
end

ActiveAdmin.register Responder do
end
