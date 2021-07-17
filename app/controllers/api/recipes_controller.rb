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

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to :show
    else
      render json: {
        errors: @recipe.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :id,
      :name,
      :image_url,
      :description,
      steps_attributes: [
        :id,
        :instruction,
        :order,
        step_ingredients: [
          :amount,
          :condition,
          :unit,
          ingredients: [
            :name,
            :descriptionx
          ]
        ]
      ]
    )
  end
end
