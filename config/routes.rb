Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  post "users/follows", to: "user#follow"
  delete "users/unfollows", to: "user#unfollow"

  post "sessions", to: "sessions#create"

  get "sleep_records", to: "sleep_records#index"
  get "sleep_records/following", to: "sleep_records#following_sleep_records"
  post "sleep_records/clock_in", to: "sleep_records#clock_in"
  post "sleep_records/:id/clock_out", to: "sleep_records#clock_out"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
