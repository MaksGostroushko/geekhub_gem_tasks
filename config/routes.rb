Rails.application.routes.draw do
  get :pages, to: 'pages#index'
  get :show, to: 'pages#show'

  root 'pages#index'
end
