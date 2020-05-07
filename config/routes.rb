Rails.application.routes.draw do
  # new index show edit create update destroy
  devise_for :admins
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions:      "users/sessions",
  }

  scope module: :user do
    # users
    resources :users, except:[:new,:index,:create]
    get 'users/exit' => 'users#exit'
    # addresses
    resources :addresses, only:[:create,:update,:destroy]
    # cart_items
    resources :cart_items, only:[:index,:create,:update,:destroy]
    # orders
    resources :orders, only:[:index,:new,:create]
    get 'orders/thanks'
    # items
    resources :items, only:[:index,:show]
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
    resources :lebels, only:[:index,:create,:update,:destroy]
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
