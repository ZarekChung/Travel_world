Rails.application.routes.draw do
  devise_for :users

  root "events#index"

  resources :events do 
    member do 
      get :schedules
      post :schedules
    end
    resources :schedules
  end 

end
