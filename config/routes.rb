Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'homes#top'
  resources :users do
    collection do
      get :my_show
    end
  end
  resources :homes
  resources :events
  resources :tournaments do
    collection do
      post :new, path: :new, as: :new, action: :back
      post :confirm
      post :complete
    end
    resource :entries
    resources :posts do
      collection do
      post :new, path: :new, as: :new, action: :back
      post :confirm
    end
    end
  end
  
  # get '/tournaments', to: 'tournaments#create', as: 'confirm'
end
