Rails.application.routes.draw do
  root to: 'landings#home'

  resources :recipes, except: [:new, :edit]

  namespace :api do
    resources :recipes, except: [:new, :edit]

    scope '/recipes/:recipe_id' do
      resources :steps, only: [:create, :update, :destroy]
      resources :step_ingredients, only: [:create, :update, :destroy]
      resources :citations, only: [:create, :update, :destroy]
      resources :authors, only: [:create, :update, :destroy]
    end

    resources :ingredients, only: [:create, :update, :destroy, :show]
  end
end
