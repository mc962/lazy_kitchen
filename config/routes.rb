Rails.application.routes.draw do
  root to: 'landings#home'

  namespace :manage do
    namespace :legacy do
      resources :recipes do
        resources :steps, except: :index do
          resources :step_ingredients, except: :index
        end

        resources :citations, except: :index do
          resources :authors, except: :index
        end
      end
    end
  end

  resources :recipes, only: [:index, :show]

  namespace :api do
    resources :recipes, only: [:index, :show]
  end
end
