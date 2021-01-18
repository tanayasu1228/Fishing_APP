Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'user_registrations'
  }
  devise_scope :user do
    post '/guest_sign_in', to: 'sessions#new_guest'
  end
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
  resources :gps_checks, only: [:new, :create
  resources :tournaments do
    collection do
      post :new, path: :new, as: :new, action: :back
      post :confirm
      get :ranks
    end
    resource :entries
    resources :posts do
      resource :nices, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      collection do
      post :new, path: :new, as: :new, action: :back
      post :confirm
      end
      member do
        get :record
        get :ranks
      end
    end
  end
end