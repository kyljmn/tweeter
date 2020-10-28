Rails.application.routes.draw do
  get 'user/index'
  get 'user/show'
  devise_for :users

  resources :user, only: %i[index show] do
    resources :twits, only: %i[create destroy] do
      member do
        post 'retwit'
        delete 'unretwit'
      end
    end
    member do
      get 'follower_index', controller: 'follow'
      get 'following_index', controller: 'follow'
      post 'follow', controller: 'follow'
      delete 'unfollow', controller: 'follow'
    end
  end
  
  root 'home#index'
end
