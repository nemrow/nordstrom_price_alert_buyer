NordstromPriceAlertBuyer::Application.routes.draw do
  root :to => 'welcome#index'

  resources :users
  resources :vendor_credentials

  get "login", :to => 'sessions#new'
  post "login", :to => 'sessions#create'
  match "logout", :to => 'sessions#destroy'

end
