Postit::Application.routes.draw do
  get "static_pages/about"

  get "static_pages/contact"

  root to: 'posts#index'
  get "/register",  to: 'users#new'
  get "/login",     to: 'sessions#new'
  post "/login",    to: 'sessions#create'
  get "/logout",    to: 'sessions#destroy'
  get "/about",     to: 'static_pages#about'

  #resources :posts
  resources :posts, except:[:destroy] do
    member do
      post 'vote'   
    end

    resources :categories, only:[:show, :index]
    resources :comments do
      member do
        post 'vote'
      end
    end
 end

  resources :users, only:[:create] do

  end

  resources :categories, except:[:destroy] do
    resources :posts, only:[:show]
  end
end
