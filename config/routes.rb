Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "home#index"

  post "/reservations/new", to: "reservations#new"

  resources :rooms do
    collection do
      get 'myindex'
      get 'search'
    end
  end

  resources :users
  resources :rooms
  resources :reservations
end
