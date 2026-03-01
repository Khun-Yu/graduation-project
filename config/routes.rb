Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  resources :questions, only: [:index, :show, :new, :create]
  get "mypage", to: "mypage#show"

  get "up" => "rails/health#show", as: :rails_health_check
end
