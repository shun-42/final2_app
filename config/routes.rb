Rails.application.routes.draw do
  resources :groups do
    resource :group_user, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  get "searches/search"
  
  root to: "homes#top"
  get 'home/about' => 'homes#about', as: 'home_about'
  resources :users, only: [:new, :create, :index, :show, :edit, :update], path: 'users', path_names: { new: 'sign_up' } do
      # この中にフォロー機能を入れる（ネスト）
      resource :relationships, only: [:create, :destroy]
  
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
  end
  resource :session
  resources :passwords, param: :token
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :chats, only: [:show, :create]



  resources :books, only: [:new, :create, :index, :show, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create,:destroy]
  end

  get "search" => "searches#search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
