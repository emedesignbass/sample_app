Rails.application.routes.draw do
  get 'sessions/new'
  
  root "static_pages#home"
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get  "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :users do
    member do
      get :edit_account_activation
      get :edit_password_reset
    end
  end
  
  # パスワードリセット用のルートを追加
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
end
