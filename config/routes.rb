Rails.application.routes.draw do
  root 'posts#index'
  get 'pages/about'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :posts do
    get '/like', to: 'posts#like', on: :member
    resources :comments
    resources :likes
  end
  resources :users do
  end 
end