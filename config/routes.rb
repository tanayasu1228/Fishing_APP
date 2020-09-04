Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'homes#top'
  resources :users
  resources :homes
  resources :events
  resources :tournaments do
    collection do
      post :new, path: :new, as: :new, action: :back
      post :confirm
      post :complete
    end
  end
  # get '/tournaments', to: 'tournaments#create', as: 'confirm'
end
