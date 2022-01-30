# frozen_string_literal: true

class Manage::RecipesController < Manage::ApplicationController
  include FormRenderable

  helper_method :render_frame_tab

  def index
    @recipes = Recipe.owned(current_user.id).directory_recipes(params[:page])
    authorize!

    render :index
  end

  def show
    @recipe = Recipe.friendly.find(params[:id])
    authorize! @recipe

    render :show
  end

  def new
    @recipe = Recipe.new
    authorize!

    if turbo_frame_request?
      render_frame_tab(params[:tab], manage_recipes_path)
    else
      render :new
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    # Associate Recipe created through Public Endpoints with currently authenticated user
    @recipe.user = current_user
    authorize! @recipe

    if @recipe.save
      flash.notice = 'Recipe created successfully.'
      redirect_to manage_recipe_path(@recipe)
    else
      flash.now[:error] = @recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe = Recipe.friendly.find(params[:id])
    authorize! @recipe

    if turbo_frame_request?
      render_frame_tab(params[:tab], manage_recipe_path(@recipe))
    else
      render :edit
    end
  end

  def update
    @recipe = Recipe.friendly.find(params[:id])
    authorize! @recipe

    if @recipe.update(recipe_params)
      purge_deleted_attachments(params[:deleted_resource_img_ids]) if params[:deleted_resource_img_ids].present?

      flash.notice = 'Recipe updated successfully.'
      redirect_to manage_recipe_path(@recipe)
    else
      flash.now[:error] = @recipe.errors.full_messages
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.friendly.find(params[:id])
    authorize! @recipe

    Recipe.destroy(@recipe.id)

    redirect_to manage_recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :id,
      :name,
      :description,
      :publicly_accessible,
      :primary_picture,
      gallery_pictures: [],
      steps_attributes: %i[
        id
        order
        instruction
        _destroy
      ]
    )
  end

  def purge_deleted_attachments(deleted_attachment_ids)
    attachments = ActiveStorage::Attachment
                  .where(id: deleted_attachment_ids, record_type: 'Recipe')
                  .joins('JOIN recipes ON active_storage_attachments.record_id = recipes.id')
                  .joins('JOIN users ON recipes.user_id = users.id')
                  .where('users.id = ?', current_user.id)
    attachments.map(&:purge)
  end
end
