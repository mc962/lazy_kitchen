Rails.application.routes.draw do
  devise_for :users
  root to: 'landings#home'

  namespace :manage do
    resources :recipes do
      resources :steps do
        resources :ingredients
      end
    end
  end

  resources :recipes, only: [:index, :show]

  namespace :api do
    resources :recipes, only: [:index, :show]
  end

  # Routes for Error Handling
  match '/403', to: 'errors#forbidden', via: :all
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
