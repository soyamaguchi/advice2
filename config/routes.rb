Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'contents#index'
  get '/terms',   to: 'contents#index'
  get '/privacy', to: 'contents#index'
  get '/license', to: 'contents#index'

  namespace :api, format: 'json' do
    resources :contents, only: %w(index)
  end
end
