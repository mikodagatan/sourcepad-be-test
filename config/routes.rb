# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  namespace :api do
    post 'authenticate', to: 'auth#authenticate'
    post 'authorize', to: 'auth#authorize'
  end
end
