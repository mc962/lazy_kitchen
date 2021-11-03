Rails.application.routes.draw do
  root to: 'landings#home'

  namespace :manage do
    namespace :legacy do
      resources :recipes do
        resources :steps, except: :index do
          resources :step_ingredients, except: :index
        end

        resources :citations do
          resources :authors
        end
      end
    end
  end

  resources :recipes, except: [:new, :edit]

  namespace :api do
    resources :recipes, only: [:index, :show]

    resources :ingredients, only: [:index, :show]
  end
end
