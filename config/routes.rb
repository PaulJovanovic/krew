Krew::Application.routes.draw do
  resources :groups do
    resources :relationships
  end
  resources :users
  get 'sign_in', to: 'sessions#new', as: "sign_in"
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  root to: "home#index"
end
