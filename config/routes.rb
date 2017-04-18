Rails.application.routes.draw do

  get 'places/get_station'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'welcome#index'

  get 'order/list'
  get 'order/new'
  post 'order/create'
  patch 'order/update'
  get 'order/list'
  get 'order/show'
  get 'order/edit'
  get 'order/delete'
  get 'order/update'

  get 'welcome/index'
  post 'welcome/send_email'
  get 'order/new'

  get '/places/get_stations/:name', to: 'places#get_stations'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
