# frozen_string_literal: true

class Manage::StepsController < Manage::ApplicationController
  include FormRenderable
  include Imageable

  helper_method :render_frame_tab

  def edit
    @step = Step.joins(:recipe).where(recipes: {slug: params[:recipe_id]}).find(params[:id])
    authorize! @step

    @recipe = @step.recipe

    if turbo_frame_request?
      render_frame_tab(params[:tab], manage_recipe_step_path(params[:recipe_id], params[:id]))
    else
      render :edit
    end
  end

  def update
    @step = Step.includes(:recipe).find(params[:id])
    authorize! @step

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
          _destroy
        ] }
      ]
    )
  end
end
