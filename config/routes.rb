Rails.application.routes.draw do
  resources :comments
  resources :posts do
    resources :likes, only: [:create, :destroy], on: :member
  end

  get "posts/:post_id/likes_count", to: "likes#update_likes_count", as: :update_likes_count

  post '/uploads/image', to: 'uploads#image'

  get 'dashboard', to: 'dashboard#index'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dashboard#index"

  # admin
  namespace :admin do
    resources :users
    resources :posts
    resources :comments
  end
end
