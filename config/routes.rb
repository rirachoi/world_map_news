Rails.application.routes.draw do

  root :to => 'pages#index'

  get '/users/mynews' => 'users#mynews'

  resources :pages, :only => [:index]
  resources :users
  resources :categories, :only => [:index, :show, :create]
  resources :countries, :only => [:index, :show]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'

end


#         root GET    /                         pages#index
# users_mynews GET    /users/mynews(.:format)   users#mynews
#        pages GET    /pages(.:format)          pages#index
#        users GET    /users(.:format)          users#index
#              POST   /users(.:format)          users#create
#     new_user GET    /users/new(.:format)      users#new
#    edit_user GET    /users/:id/edit(.:format) users#edit
#         user GET    /users/:id(.:format)      users#show
#              PATCH  /users/:id(.:format)      users#update
#              PUT    /users/:id(.:format)      users#update
#              DELETE /users/:id(.:format)      users#destroy
#   categories GET    /categories(.:format)     categories#index
#              POST   /categories(.:format)     categories#create
#     category GET    /categories/:id(.:format) categories#show
#    countries GET    /countries(.:format)      countries#index
#      country GET    /countries/:id(.:format)  countries#show
#        login GET    /login(.:format)          sessions#new
#              POST   /login(.:format)          sessions#create
#              DELETE /login(.:format)          sessions#destroy