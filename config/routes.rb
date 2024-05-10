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

  # イベント管理ページ
  scope :manage, as: :manage do
    get 'events', to: 'events#manage_events'

    resources :categories, as: :category do
      get 'events', to: 'events#manage_events'
    end

    get 'events/:event_day/events', to: 'events#manage_events', as: 'date_events'
  end
end