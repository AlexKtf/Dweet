Rails.application.routes.draw do
  
  devise_for :users

  devise_scope :user do
    get '/admin', to: 'admin/sessions#new'
    post '/admin', to: 'admin/sessions#create'
  end

  resources :categories, only: [:show]
  resources :playlists, only: [:show]

  namespace :admin do
    resources :dashboard, only: :index
    resources :categories, only: [:create, :show, :destroy]
    resources :artists, only: [:create, :show, :destroy]
    resources :playlists, only: [:create, :show, :destroy]
  end
  root to: "home#index"
end
