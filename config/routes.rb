Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :registration, only: %i[new create]
  
  resources :walls
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get :maisonscript, to: "pages#maisonscript"
    get "who-we-are", to: "pages#who_we_are", as: "who_we_are"
    get "what-we-do", to: "pages#what_we_do", as: "what_we_do"
    get :vision, to: "pages#vision", as: "vision"
    get :privacy, to: "pages#privacy", as: "privacy"
    root "pages#home"
  end
end
