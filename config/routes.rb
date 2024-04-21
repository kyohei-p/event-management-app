Rails.application.routes.draw do
  root "events#index"

  get 'login' => 'sessions#new', as: :login
  post 'login' => "sessions#create"
  delete 'logout' => 'sessions#destroy', as: :logout

  resources :users, except: [:index]
  resources :events
end
