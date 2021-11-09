class API::RecipesController < API::ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)

    render json: @recipes.map { |recipe|
                   {
                     id: recipe.id,
                     name: recipe.name,
                     image_url: recipe.image_url,
                     _link: api_recipe_url(recipe)
                   }
                 }
  end

  def show
    @recipe = Recipe.includes(:steps, :ingredients, :citations).where(user_id: current_user.id).friendly.find(params[:id])

    render json: @recipe, include: {
      steps: {
        include: {
          step_ingredients: {
            include: :ingredient
          }
        }
      },
      citations: {
        include: :authors
      }
    }
  end
end
