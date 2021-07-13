class API::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    render json: @recipes
  end

  def show
    @recipe = Recipe.includes(:steps, :ingredients).find(params[:id])

    render json: @recipe, include: {
      steps: {
        include: {
          step_ingredients: {
            include: :ingredient
          }
        }
      }
    }
  end
end
