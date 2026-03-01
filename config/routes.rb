Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  resources :questions, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end
  get "mypage", to: "mypage#show"
  get "terms", to: "static_pages#terms"
  get "privacy", to: "static_pages#privacy"

  get "up" => "rails/health#show", as: :rails_health_check
end
