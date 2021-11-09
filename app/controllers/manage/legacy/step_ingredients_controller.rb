class Manage::Legacy::StepIngredientsController < Manage::Legacy::ApplicationController
  def show
    @step_ingredient = StepIngredient.where(step_id: params[:step_id]).find(params[:id])
    authorize! @step_ingredient

    render :show
  end

  def new
    @step_ingredient = StepIngredient.new(step_id: params[:step_id], ingredient: Ingredient.new)
    authorize!

    render :new
  end

  def create
    @step_ingredient = StepIngredient.new(step_ingredient_params)
    authorize! @step_ingredient

    if @step_ingredient.save
      flash.notice = 'Step Ingredient created successfully.'
      redirect_to manage_legacy_recipe_step_step_ingredient_path(@step_ingredient)
    else
      flash.now[:error] = @step_ingredient.errors.full_messages
      render :new
    end
  end

  def edit
    @step_ingredient = StepIngredient.where(step_id: params[:step_id]).find(params[:id])
    authorize! @step_ingredient

    render :edit
  end

  def update
    @step_ingredient = StepIngredient.where(step_id: params[:step_id]).find(params[:id])
    authorize! @step_ingredient

    if @step_ingredient.update(step_ingredient_params)
      flash.notice = 'Step Ingredient updated successfully.'
      redirect_to manage_legacy_recipe_step_step_ingredient_path(@step_ingredient)
    else
      flash.now[:error] = @step_ingredient.errors.full_messages
      render :new
    end
  end

  def destroy
    @step_ingredient = StepIngredient.where(step_id: params[:step_id]).find(params[:id])
    authorize! @step_ingredient

    StepIngredient.destroy(@step_ingredient.id)

    redirect_to manage_legacy_recipe_step_step_ingredients_path
  end

  private

  def step_ingredient_params
    params.require(:step_ingredient).permit(
      :id,
      :amount,
      :condition,
      :unit,
      ingredient_attributes: %i[
        id
        name
        description
      ]
    )
  end
end
