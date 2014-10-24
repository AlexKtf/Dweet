Rails.application.routes.draw do
  
  devise_for :users

  devise_scope :user do
    get '/admin', to: 'admin/sessions#new'
    post '/admin', to: 'admin/sessions#create'
  end

  resources :categories, only: [:index, :show] do
    get '/:id', to: 'videos#show'
  end

  get '/home-items', to: 'home#home_items'

  namespace :admin do
    resources :dashboard, only: :index
    resources :categories, only: [:create, :show, :destroy]
    resources :artists, only: [:create, :show, :destroy]
    resources :playlists, only: [:create, :show, :destroy]
    resources :videos, only: [:create, :destroy]
  end

  root to: "home#index"
end
