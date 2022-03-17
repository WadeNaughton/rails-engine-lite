Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'search#find'
      get '/merchants/most_items', to: 'merchants#most_items'
      get '/items/find_all', to: 'search#find_all'

      resources :items do
        resources :merchant, only: [:index], controller: "items_merchant"
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "merchant_items"

      end
      namespace :revenue do
        resources :merchants, only: [:index, :show]

      end
    end
  end
end
