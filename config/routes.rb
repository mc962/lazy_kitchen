Rails.application.routes.draw do
  root to: 'landings#home'

  resources :recipes, except: [:new, :edit]

  namespace :api do
    resources :recipes, except: [:new, :edit]
  end
end
