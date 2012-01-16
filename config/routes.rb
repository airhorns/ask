Ask::Application.routes.draw do

  mount Resque::Server.new, :at => "/admin/resque"
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :customers

  scope '/api/twilio', :as => 'twilio' do
    match '/receive/:phone_number' => "twilio#receive"
  end

  scope '/api/tropo', :as => 'tropo' do
    match '/receive' => "tropo#receive"
  end

  root :to => "dashboard#app"

  constraints :format => :json do
    resources :surveys, :except => [:edit] do
      resources :questions, :only => [:index, :new, :create]
      resources :alerts, :only => [:index, :new, :create]
      resources :responses, :only => [:index]
      resources :survey_segments, :only => [:index, :new, :create]
      get :start, :on => :member
    end

    resources :responders, :except => [:edit, :destroy, :create] do
      resources :responses, :only => [:index]
    end

    resources :questions, :only => [:show, :update, :destroy] do
      get :stats, :on => :member
      resources :alerts, :only => [:new, :create]
    end

    resources :responses, :only => [:show, :destroy] do
      resources :answers, :only => [:index]
    end

    resources :survey_segments, :except => [:index, :new, :create]
    resources :answers, :only => [:show, :destroy]
    resources :alerts, :only => [:show, :update, :destroy]
  end
end
