class API::RecipesController < API::ApplicationController
  def index
    @recipes = Recipe.all

    render json: @recipes
  end

  def show
    @recipe = Recipe.includes(:steps, :ingredients, :citations).find(params[:id])

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

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      render json: {
        path: recipe_path(@recipe)
      }, status: :created
    else
      render json: {
        errors: @recipe.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      render json: {
        path: recipe_path(@recipe)
      }
    else
      render json: {
        errors: @recipe.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      Recipe.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("No Recipe to delete with id of #{params[:id]}")
    end

    render json: {
      path: recipe_path(params[:recipe_id])
    }
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :id,
      :name,
      :image_url,
      :description,
      :publicly_accessible,
      steps_attributes: [
        :id,
        :name,
        :description
      ]
    )
  end
end
