Darkcoinpool::Application.routes.draw do
  match '/home', :to => 'pages#home'
  match '/contact', :to => 'pages#contact'
  match '/help', :to => 'pages#help'
  match '/about', :to => 'pages#about'

  get '/users/new'

  match '/signup', :to => 'users#new'

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
