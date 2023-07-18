Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ('/')
  # root 'articles#index"

  root 'application#welcome'

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  get '/register', to: 'users#new', as: 'register'
  post '/register', to: 'users#create'

  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/discover', to: 'movies#discover', as: 'discover'
  
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  
  get '/users/:user_id/movies/:movie_id', to: 'movies#show', as: 'movie_show'
  get '/users/:user_id/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new', as: 'new_viewing_party' 
  post '/users/:user_id/movies/:movie_id/viewing-party/new', to: 'viewing_parties#create', as: 'create_viewing_party'

  post '/users/:id/movies', to: 'movies#index', as: 'search'

  # post '/search', to: 'search#search'

  resources :users, only: [:new, :create, :show] do
    
  end
end
