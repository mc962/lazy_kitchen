Rails.application.routes.draw do
  root to: 'landings#home'

  get '/recipes/manage', to: 'recipes#manage'

  resources :recipes, except: [:new, :edit]
end
