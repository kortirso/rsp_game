# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'status', to: 'status#show'

      namespace :users do
        resources :token, only: %i[create]
      end
      resources :users, only: %i[create]
    end
  end

  localized do
    namespace :users do
      get 'sign_up', to: 'registrations#new'
      post 'sign_up', to: 'registrations#create'

      get 'login', to: 'sessions#new'
      post 'login', to: 'sessions#create'
      get 'logout', to: 'sessions#destroy'
    end

    resource :home, only: %i[show]
    root 'welcome#index'
  end
end
