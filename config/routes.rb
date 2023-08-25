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
    member do # memberとはresourcesで生成されるルートに、決められたルート以外のルートを追加するための処理
      get :follows, :followers
    end # Userと、Relationshipは関連づけられているためuserのidが必要なのでrelationshipsをネストする。
      resource :relationships, only: [:create, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end # endを追加