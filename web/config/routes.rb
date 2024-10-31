Rails.application.routes.draw do
  root 'monitor#index'
  get 'monitor/index'
  get 'dashboard/index'
  get '/ram_usage', to: 'monitor#ram_usage'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
