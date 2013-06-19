Postit::Application.routes.draw do
  root to: 'posts#index'
  get "/register",  to: 'users#new'
  get "/login",     to: 'sessions#new'
  post "/login",    to: 'sessions#create'
  get "/logout",    to: 'sessions#destroy'

  #resources :posts
  resources :posts, except:[:destroy] do
    member do
      #single page?    
    end

    resources :categories, only:[:show, :index]
    resources :comments
  end

  resources :users, only:[:create] do

  end

  resources :categories, except:[:destroy] do
    resources :posts, only:[:show]
  end
end
