Rails.application.routes.draw do
  devise_for :users
  root to: 'landings#index'

  get '/search', to: 'searches#index'

  resources :recipes, only: [:index, :show]

  resources :posts, only: [:index, :show]

  namespace :api do
    resources :recipes, only: [:index, :show]

    resources :posts, only: [:index, :show]
  end

  namespace :manage do
    resources :recipes do
      # Editing a step's recipes
      get '/steps/edit', to: 'recipes#edit', as: :edit_steps
      # Editing an individual step, a step's ingredients
      resources :steps, only: [:create, :edit, :update, :destroy] do
        get '/ingredients/edit', to: 'ingredients#edit', as: :edit_ingredients
        # Editing and individual ingredient
        resources :ingredients, only: [:create, :edit, :update, :destroy]
      end
    end

    get '/', to: 'users#show'
    resources :users, only: [:index, :destroy]

    resources :posts
  end

  # Routes for Error Handling
  match '/403', to: 'errors#forbidden', via: :all
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
