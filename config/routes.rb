Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :users, only: [:show, :edit, :update]

  root "events#index"

  resources :events do
    resources :schedules do
      collection do
        get :search
      end
    end
  end

  #schddules自己的routes
  resources :schedules do
    collection do
      get :get_spot_phtot
      get :search_spot
      post :add_to_wish
      delete :destroy_wish
    end
  end


end