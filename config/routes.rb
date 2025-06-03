Rails.application.routes.draw do
  get "historico/index"
  root "products#index"

  resources :historicos, only: [:index]

  resources :products do
    collection do
      get 'search'
    end
  end
end