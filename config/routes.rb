Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users 
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search" # 検索ボタンが押された時、Searchesコントローラーのsearchアクションが実行されるように定義

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy] 
    resource :favorites, only: [:create, :destroy]
  end 
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "search" => "users#search" 
  end
  
  resources :chats, only: [:show, :create]
  
  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end # endを追加