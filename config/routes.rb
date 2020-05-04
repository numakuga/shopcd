Rails.application.routes.draw do
  # new index show edit create update destroy
  devise_for :admins
  devise_for :users
  namespace :user do
    resources :users, except:[:new,:index,:create]
    get 'users/exit' => 'users#exit'
  end
  namespace :user do
    resources :addresses, only:[:create,:update,:destroy]
  end
  namespace :user do
    resources :cart_items, only:[:index,:create,:update,:destroy]
  end
  namespace :user do
    resources :orders, only:[:index,:new,:create]
    get 'orders/thanks'
  end
  namespace :user do
    resources :items, only:[:index,:show]
  end
  namespace :user do
    get 'searches/items' => 'searches#items'
    get 'searches/artists' => 'searches#artists'
  end
  
  namespace :admin do
    resources :users, except:[:new,:create]
  end
  namespace :admin do
    resources :addresses, only:[:destroy]
  end
  namespace :admin do
    resources :artists, only:[:index,:create,:update,:destroy]
  end
  namespace :admin do
    resources :lebels, only:[:index,:create,:update,:destroy]
  end
  namespace :admin do
    resources :genres, only:[:index,:create,:update,:destroy]
  end
  namespace :admin do
    resources :orders, only:[:index,:update]
  end
  namespace :admin do
    resources :items
  end
  namespace :admin do
    get 'searches/items' => 'searches#items'
    get 'searches/artists' => 'searches#artists'
    get 'searches/users' => 'searches#users'
  end
end
