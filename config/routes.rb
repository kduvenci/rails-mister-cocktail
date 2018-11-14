Rails.application.routes.draw do
  root to: 'cocktails#index'
  get '/search', to: 'cocktails#search', as: 'search_page'
  resources :cocktails, except: [:edit, :update] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]
end
