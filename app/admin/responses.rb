ActiveAdmin.register Response do

  index do
    column :responder do |response|
      link_to response.responder.phone_number, response.responder
    end
    column :survey do |response|
      link_to response.survey.name, response.survey
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
