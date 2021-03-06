Darkcoinpool::Application.routes.draw do

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :bots, :only => [:create, :destroy]

  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout',:to => 'sessions#destroy'

  match '/home',  :to => 'pages#home'
  match '/contact', :to => 'pages#contact'
  match '/help',  :to => 'pages#help'
  match '/about', :to => 'pages#about'

  resources :welcome

  resources :statistic do
    collection do
      get 'hash_per_second'
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => "pages#home"

  # See how all your routes lay out with "rake routes"
end
