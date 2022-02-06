class Manage::IngredientsController < Manage::ApplicationController
  include FormRenderable

  helper_method :render_frame_tab

  def edit
    @ingredient = Ingredient.friendly.find(params[:id])

    authorize! @ingredient

    @recipe = @ingredient.recipes.where(slug: params[:recipe_id]).first

    if turbo_frame_request?
      render_frame_tab(params[:tab], manage_recipe_step_ingredient_path(params[:recipe_id], params[:step_id], params[:id]))
    else
      render :edit
    end
  end

  def update
    @ingredient = Ingredient.friendly.find(params[:id])

    authorize! @ingredient

    if @ingredient.update(ingredient_params)
      flash.notice = 'Ingredient updated successfully.'
      redirect_to edit_manage_recipe_step_path(params[:recipe_id], params[:step_id], tab: 'step')
    else
      flash.now[:error] = @ingredient.errors.full_messages
      render :edit
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(
      :id,
      :name,
      :description,
      gallery_pictures: [],
    )
  end
end

