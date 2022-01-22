class Manage::Stable::StepsController < ApplicationController
  include FormRenderable

  helper_method :render_frame_tab

  def edit
    @step = Step.where(recipe_id: params[:recipe_id]).find(params[:id])
    @recipe = @step.recipe

    if turbo_frame_request?
      render_frame_tab(params[:tab], manage_stable_recipe_step_path(params[:recipe_id], params[:id]))
    else
      render :edit
    end
  end

  def update
    @step = Step.includes(:recipe).find(params[:id])
    @recipe = @step.recipe

    if @step.update(step_params)
      flash.notice = 'Step updated successfully.'
      redirect_to edit_manage_stable_recipe_path(@step.recipe, tab: 'steps')
    else
      flash.now[:error] = @step.errors.full_messages
      render :edit
    end
  end

  private

  def step_params
    params.require(:step).permit(
      :id,
      :order,
      :instruction,
      step_ingredients_attributes: [
        :id,
        :amount,
        :condition,
        :unit,
        :_destroy,
        ingredient_attributes: %i[
          id
          name
          description
          _destroy
        ]
      ]
    )
  end
end
