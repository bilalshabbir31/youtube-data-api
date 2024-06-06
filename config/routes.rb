# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :channels, except: %i[new edit create update]

  resources :home, only: :index do
    collection do
      get 'fetch_channel_videos', to: 'home#fetch_channel_videos', as: 'fetch_channel_videos'
    end
  end
  # Defines the root path route ("/")
  root 'channels#index'
end
