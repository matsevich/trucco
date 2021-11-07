Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :admins
    root to: 'main#index'

    resources :categories, except: :show
    resources :products do
      resources :prices, only: %i[edit update destroy] do
        get 'sell_form', on: :member
        patch 'sell', on: :member
      end
    end
  end
end
