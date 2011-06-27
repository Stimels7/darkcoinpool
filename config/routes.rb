Darkcoinpool::Application.routes.draw do
  get "pages/home"
  get "pages/contact"
  get "pages/about"
  get "users/new"
  
  resources :welcome

  resources :statistic do
    collection do
      get 'hash_per_second'
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"
end
