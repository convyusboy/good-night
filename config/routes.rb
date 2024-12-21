Rails.application.routes.draw do
  resources :connections
  resources :sleeps
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "users/:id/sleeps" => "users#sleeps", as: :user_sleeps
  get "users/:id/feed" => "users#feed", as: :user_feed
  post "users/:id/clock_in" => "users#clock_in", as: :user_clock_in
  patch "users/:id/clock_out" => "users#clock_out", as: :user_clock_out
  post "users/:id/follow/:following_id" => "users#follow", as: :user_follow
  patch "users/:id/unfollow/:following_id" => "users#unfollow", as: :user_unfollow

  # Defines the root path route ("/")
  # root "posts#index"
end
