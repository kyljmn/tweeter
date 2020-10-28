Rails.application.routes.draw do
  devise_for :users

  resources :user, only: %i[index show] do
    resources :twits, only: %i[index create destroy]
    member do
      get 'follower_index', controller: 'follow'
      get 'following_index', controller: 'follow'
      post 'follow', controller: 'follow'
      delete 'unfollow', controller: 'follow'
    end
  end
  
  root 'home#index'
end
