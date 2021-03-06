Rails.application.routes.draw do
  root "products#home"
  get "/home", to: "products#home"
  get "/introduce", to: "static_pages#introduce"
  get "/register", to: "accounts#new"
  post "/register", to: "accounts#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/show/:id", to: "products#show"
  resources :accounts, except: %i( index destroy )
  resources :products
  namespace :admin do
    root "static_pages#index"
  end
end
