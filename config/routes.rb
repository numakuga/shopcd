Rails.application.routes.draw do

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
      get 'orders/confirm'
      get 'orders/thanks'
      # favorites
      get 'favorites' => 'favorites#index'
    end

    # addresses
    resources :addresses, only:[:create,:update,:destroy]

    # items
    resources :items, only:[:show] do
      # favorites
      resource :favorites, only:[:create, :destroy]
    end

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
    resources :artists, only:[:index,:create,:update,:destroy,:edit]
    # lebels
    resources :labels, only:[:index,:create,:update,:destroy,:edit]
    # genres
    resources :genres, only:[:index,:create,:update,:destroy,:edit]
    # orders
    resources :orders, only:[:index,:update]
    # items
    resources :items
    get 'searches/items' => 'searches#items'
    get 'searches/artists' => 'searches#artists'
    get 'searches/users' => 'searches#users'
  end
end
