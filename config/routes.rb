Rails.application.routes.draw do
  root to: 'homes#top'
  resources :events
  resources :tournaments
end
