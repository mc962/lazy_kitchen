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
    authorize_step_ingredient = StepIngredient.new(
      step_ingredient_params
    )

    authorize_step_ingredient.step = Step.new(
      authorize_step_ingredient.step.attributes.merge(Step.managed.find(authorize_step_ingredient.step.id).attributes)
    )
    authorize_step_ingredient.ingredient = Ingredient.managed.find_or_initialize_by(
      {
        **authorize_step_ingredient.ingredient.attributes,
        # Adding current_user here will have the effect of always searching for only the current user's ingredient,
        # and if not then create a new ingredient owned by the user.
        user: current_user
      }
    )
    authorize! authorize_step_ingredient

    @step_ingredient = StepIngredient.new(step_ingredient_params)
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

    redirect_to manage_legacy_recipe_step_path(@step_ingredient.step.recipe.id, @step_ingredient.step)
  end

  private
  # TODO ingredients_controller, acepts nested Ingredient, instead
  def step_ingredient_params
    params.require(:step_ingredient).permit(
      :id,
      :amount,
      :condition,
      :unit,
      :step_id,
      ingredient_attributes: %i[
        id
        name
        description
      ]
    )
  end
end
