Rails.application.routes.draw do

  get 'tasks/list'
  get 'tasks/show'

  devise_for :users
  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
  end
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
  patch 'order/cancel/:id', to: 'order#cancel'

  get 'welcome/index'
  post 'welcome/send_email'
  get 'order/new'

  get '/places/get_stations/:name', to: 'places#get_stations'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
