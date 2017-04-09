Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'welcome#index'
  get 'welcome/index'
  post 'welcome/send_email'
  get 'order/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
