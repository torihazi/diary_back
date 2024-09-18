Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      
      devise_for :users, 
      controllers: { 
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions',
        confirmations: 'devise/confirmations'
      }

      resources :diaries

    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check

end
