Rails.application.routes.draw do
  devise_for :users

  root "events#index"

  resources :events do
    member do
      post :schedules
    end
    resources :schedules do      
    end    
  end

  resources :details

end
