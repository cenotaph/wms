Rails.application.routes.draw do
  devise_for :users, :controllers => {  omniauth_callbacks: 'omniauth_callbacks' } do
    get "logout", to: "devise/sessions#destroy"
  end
  match '/users/auth/:provider/callback' => 'authentications#create', :via => :get
  resources :users do
    get :register_as_teacher
    get :register_as_student
    member do
      get :calendar
    end
  end
  
  resources :bookings
  
  match '/schedule/by_day/:wday' => 'regularavailabilities#by_day', via: :get
  resources :regularavailabilities 
  
  resources :specialavailabilities
  
  namespace :admin do
    root to: 'base#home'
    resources :legacyteachers
    resources :users

  end
    
  root to: 'users#show'
end
