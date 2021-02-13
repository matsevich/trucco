Rails.application.routes.draw do
  devise_for :admins
  root to: 'main#index'

  resources :categories, except: :show
end
