Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  
  resources :users do
    resources :twits
  end
  
  root 'home#index'
end
