Rails.application.routes.draw do
  devise_for :users

  resources :user do
    resources :twits, only: %i[index new create destroy]
  end
  
  root 'home#index'
end
