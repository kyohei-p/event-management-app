Rails.application.routes.draw do
  root "events#index"

  get 'login' => 'sessions#new', as: :login
  post 'login' => "sessions#create"
  get 'logout' => 'sessions#destroy', as: :logout

  resources :users, except: [:index]

  resources :events

  resources :categories do
    resources :events, only: [:index]
  end

  get 'events/:event_day/events', to: 'events#index', as: 'date_events'

end