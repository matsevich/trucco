Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :admins
    root to: 'main#index'

    resources :categories, except: :show
  end
end
