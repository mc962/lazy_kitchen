# frozen_string_literal: true

class Manage::StepsController < Manage::ApplicationController
  include FormRenderable
  include Imageable

  helper_method :render_frame_tab

  def edit
    @steps = Step.joins(:recipe).where(recipes: {slug: params[:recipe_id]}).includes(:recipe)
    @recipe = @steps.first.recipe
    authorize! @recipe, with: RecipePolicy

    render :edit
  end

  def update
    @step = Step.includes(:recipe).find(params[:id])
    authorize! @step

    # Expose needed nested models associated with main model for page
    @recipe = @step.recipe

    if @step.update(step_params)
      purge_deleted_attachments(params[:deleted_resource_img_ids], :step) if params[:deleted_resource_img_ids].present?

      flash.notice = 'Step updated successfully.'
      redirect_to edit_manage_recipe_path(@step.recipe, tab: 'steps')
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
      gallery_pictures: [],
      step_ingredients_attributes: [
        :id,
        :amount,
        :condition,
        :unit,
        :gallery_pictures,
        :_destroy,
        { ingredient_attributes: %i[
          id
          name
          description
          user_id
          _destroy
        ] }
      ]
    )
  end
end
