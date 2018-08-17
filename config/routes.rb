Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :update, :create, :destroy]
      resources :articles, only: [:index, :update, :create, :destroy]
      resources :bookmarks, only: [:index, :update, :create, :destroy]
    end
  end
end
