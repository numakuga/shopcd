Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  get 'favorites/index'
  # new index show edit create update destroy

  devise_for :admins
  devise_for :users

  scope module: :users do

    root 'items#index'
    # users
    get 'users/:id/exit' => 'users#exit', as: :user_exit
    resources :users, except:[:new,:index,:create] do
      # cart_items
      resources :cart_items, only:[:index,:create,:update,:destroy]
      # orders
      resources :orders, only:[:index,:new,:create]
      get 'orders/thanks'
    end
    
    # addresses
    resources :addresses, only:[:create,:update,:destroy]
    # items
    resources :items, only:[:show]
    # searches
    get 'searches/items' => 'searches#items'
    get 'searches/artists' => 'searches#artists'
  end

  namespace :admin do
    # users
    resources :users, except:[:new,:create]
    # addresses
    resources :addresses, only:[:destroy]
    # artists
    resources :artists, only:[:index,:create,:update,:destroy]
    # lebels
    resources :labels, only:[:index,:create,:update,:destroy]
    # genres
    resources :genres, only:[:index,:create,:update,:destroy]
    # orders
    resources :orders, only:[:index,:update]
    # items
    resources :items
    get 'searches/items' => 'searches#items'
    get 'searches/artists' => 'searches#artists'
    get 'searches/users' => 'searches#users'
  end
end
