# frozen_string_literal: true

Rails.application.routes.draw do
  post '/login',   to: 'authentication#create'
  resource :users, only: %i[show create update destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
