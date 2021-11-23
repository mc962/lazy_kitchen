# frozen_string_literal: true

class API::RecipesController < API::ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)

    render json: @recipes.map { |recipe|
                   {
                     id: recipe.id,
                     name: recipe.name,
                     primary_picture: url_for(recipe.primary_picture),
                     _link: api_recipe_url(recipe)
                   }
                 }
  end

  def show
    @recipe = Recipe.includes(:steps, :ingredients,
                              :citations).where(user_id: current_user.id).friendly.find(params[:id])

    render json: {
      id: @recipe.id,
      name: @recipe.name,
      description: @recipe.description,
      publicly_accessible: @recipe.publicly_accessible,
      primary_picture: url_for(@recipe.primary_picture),
      gallery_pictures: @recipe.gallery_pictures.map { |attachment| url_for(attachment) }
    }, include: {
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
