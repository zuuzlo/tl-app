Postit::Application.routes.draw do
  root to: 'posts#index'
  #resources :posts
  resources :posts, except:[:destroy] do
    member do
      #single page?    
    end

    resources :categories, only:[:show, :index]
    resources :comments
  end

  resources :users, except:[:destroy] do

  end
end
