class Manage::Legacy::StepIngredientsController < ApplicationController
  # @todo Authenticate
  def show
    @step_ingredient = StepIngredient.find(params[:id])

    render :show
  end

  def new
    @step_ingredient = StepIngredient.new(step_id: params[:step_id], ingredient: Ingredient.new)

    render :new
  end

  def create
    @step_ingredient = StepIngredient.new(step_ingredient_params)

    if @step_ingredient.save
      flash.notice = 'Step Ingredient created successfully.'
      redirect_to manage_legacy_recipe_step_step_ingredient_path(@step_ingredient)
    else
      flash.now.error = @step_ingredient.errors.full_messages
      render :new
    end
  end

  def edit
    @step_ingredient = StepIngredient.find(params[:id])

    render :edit
  end

  def update
    @step_ingredient = StepIngredient.find(params[:id])

    if @step_ingredient.update(step_ingredient_params)
      flash.notice = 'Step Ingredient updated successfully.'
      redirect_to manage_legacy_recipe_step_step_ingredient_path(@step_ingredient)
    else
      flash.now.error = @step_ingredient.errors.full_messages
      render :new
    end
  end

  def destroy
    begin
      @step_ingredient.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("Record not found with id #{params[:id]}, deletion was skipped.")
    end

    redirect_to manage_legacy_recipe_steps_step_ingredients_path
  end

  private

  def step_ingredient_params
    params.require(:step_ingredient).permit(
      :id,
      :amount,
      :condition,
      :unit,
      ingredient_attributes: [
        :id,
        :name,
        :description
      ]
    )
  end
end
