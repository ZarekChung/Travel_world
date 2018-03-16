Rails.application.routes.draw do
  get 'replies/create'

  devise_for :users

  resources :events do
    resources :replies, only: [:create]
    collection do
      get :search
    end

    member do
      post :favorite
      post :unfavorite
    end
  end
  
  resources :users do
    member do
      get :events
    end
  end
  
  root "events#index"
end
