Rails.application.routes.draw do
  root 'lists#index'
  resources :lists do
    collection do
      get 'search'
    end
  end
end
