Rails.application.routes.draw do
  devise_for :users
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

    namespace :stable do
      resources :recipes do
        resources :steps
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
