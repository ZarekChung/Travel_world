Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :users, only: [:show, :edit, :update]

  resources :events do
    resources :replies, only: [:create]
    collection do
      get :search
    end

    member do
      post :favorite
      post :unfavorite

      post :report

      post :clone

      get :schedules
      patch :schedulep

    end

    resources :schedules do
      collection do
        get :search
      end
    end
  end

  resources :users do
    member do
      get :events
    end
  end

  #schddules自己的routes
  resources :schedules do
    collection do
      #get :search_spot
      #post :add_to_wish
      delete :destroy_wish
    end
    member do
      get :get_distance
    end
  end

  root "events#index"

  # backend routes seup
  namespace :admin do
    resources :events, only: [:index, :show] do
      member do
        post :unreport
        post :disable
      end
    end
    resources :users, only: [:index, :update] do
      member do
        post :suspend
      end
    end
    root "events#index"
  end

 resources :details
 resources :spots, only: [:show, :new] do
  collection do
      get :get_phtot
      get :search
    end
 end

end
