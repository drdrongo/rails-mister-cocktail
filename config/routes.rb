Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'
  get 'contact', to: 'pages#contact'
  resources :cocktails do
    resources :doses, only: %i[new create index]
  end
  resources :doses, only: %i[destroy index]
end
