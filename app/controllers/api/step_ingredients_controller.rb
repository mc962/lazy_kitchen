class API::StepIngredientsController < API::ApplicationController
  def create
    @step_ingredient = StepIngredient.new(step_ingredient_params)

    if @step_ingredient.save
      render json: {
        path: recipe_path(params[:recipe_id])
      }, status: :created
    else
      render json: {
        errors: @step_ingredient.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    @step_ingredient = StepIngredient.find(params[:id])

    if @step_ingredient.update(step_ingredient_params)
      render json: {
        path: recipe_path(params[:recipe_id])
      }
    else
      render json: {
        errors: @step_ingredient.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      StepIngredient.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("No Step Ingredient to delete with id of #{params[:id]}")
    end

    render json: {
      path: recipe_path(params[:recipe_id])
    }
  end

  private

  def step_ingredient_params
    params.require(:step_ingredient).permit(
      :id,
      :amount,
      :condition,
      :unit,
      :step_id,
      ingredient_attributes: [
        :id,
        :name,
        :description
      ]
    )
  end
end

