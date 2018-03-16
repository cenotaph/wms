Rails.application.routes.draw do
  devise_for :users, :controllers => {  omniauth_callbacks: 'omniauth_callbacks' } do
    get "logout", to: "devise/sessions#destroy"
  end
  match '/users/auth/:provider/callback' => 'authentications#create', :via => :get
  resources :users do
    get :register_as_teacher
    get :register_as_student
    resources :invoices do
      member do
        get :generate_annual_student_fee
      end
    end
    member do
      get :calendar
    end
  end


  resources :bookings do
    member do
      get :choose_timeslot
      match 'by_day/:wday' => 'bookings#by_day', via: :get
      get :calendar
      get :accept
    end
  end

  resources :charges
  

  resources :nfcs do
    member do
      get :auth_door
    end
  end

  match '/schedule/by_day/:wday' => 'regularavailabilities#by_day', via: :get
  resources :regularavailabilities

  resources :specialavailabilities

  namespace :admin do
    root to: 'base#home'
    resources :bookings do
      member do
        get :mark_as_paid
      end
    end
    resources :legacyteachers
    resources :users do
      resources :nfcs
    end
    resources :invoices do
      member do
        get :mark_as_paid
      end
    end

  end


  root to: 'users#show'
end
