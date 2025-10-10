Rails.application.routes.draw do
  
  # Add www with redirect but only on production
  if Rails.env.production?
    constraints subdomain: false do
      get ":any", to: redirect(subdomain: "www", path: "/%{any}"), any: /.*/
      root to: redirect(subdomain: "www", path: "/"), as: :non_www_root
    end
  end
  
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
    get "get-involved", to: "pages#get_involved", as: "get_involved"
    get "explore", to: "pages#explore", as: "explore"
    get "start-a-project", to: "pages#start_a_project", as: "start_a_project"
    get :now, to: "pages#now", as: "now"
    get :stories, to: "pages#stories", as: "stories"
    get :events, to: "pages#events", as: "events" 
    get "communities", to: "pages#communities", as: "communities"
    get :vision, to: "pages#vision", as: "vision"
    get :privacy, to: "pages#privacy", as: "privacy"
    get :calendar, to: "pages#calendar", as: "calendar"
    get :featured, to: "pages#featured", as: "featured"
    get :members, to: "pages#members", as: "members"
    get :governance, to: "pages#governance", as: "governance"
    get :token, to: "pages#token", as: "token"
    get :cryptoartfriend, to: "pages#cryptoartfriend", as: "cryptoartfriend"
    get "crypto-art-friends", to: "pages#crypto_art_friends", as: "crypto_art_friends"
    get "become-crypto-art-friends", to: "pages#become_a_crypto_art_friend", as: "become_a_crypto_art_friend"
    root "pages#home"
  end
end
