Rails.application.routes.draw do
  devise_for :users

  resources :events do
    collection do
      get :search
    end
  end
  
  resources :users do
    member do
      get :events
    end
  end
  
  root "events#index"
end
