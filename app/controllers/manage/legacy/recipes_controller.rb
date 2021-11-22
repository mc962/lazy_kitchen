# frozen_string_literal: true

class Manage::Legacy::RecipesController < Manage::Legacy::ApplicationController
  def index
    # Only show recipes for management owned by
    #   current user
    @recipes = Recipe.where(user_id: current_user.id).directory_recipes(params[:page])
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

    render :new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    # Associate Recipe created through Public Endpoints with currently authenticated user
    @recipe.user = current_user
    authorize! @recipe

    if @recipe.save
      purge_deleted_attachments(params[:deleted_recipe_img_ids]) if params[:deleted_recipe_img_ids].present?

      flash.notice = 'Recipe created successfully.'
      redirect_to manage_legacy_recipe_path(@recipe)
    else
      flash.now[:error] = @recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe = Recipe.friendly.find(params[:id])
    authorize! @recipe

    render :edit
  end

  def update
    @recipe = Recipe.friendly.find(params[:id])
    authorize! @recipe

    if @recipe.update(recipe_params)
      purge_deleted_attachments(params[:deleted_recipe_img_ids]) if params[:deleted_recipe_img_ids].present?

      flash.notice = 'Recipe updated successfully.'
      redirect_to manage_legacy_recipe_path(@recipe)
    else
      flash.now[:error] = @recipe.errors.full_messages
      render :new
    end
  end

  def destroy
    @recipe = Recipe.friendly.find(params[:id])
    authorize! @recipe

    Recipe.destroy(@recipe.id)

    redirect_to manage_legacy_recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :id,
      :name,
      :description,
      :image_url,
      :publicly_accessible,
      :primary_picture,
      gallery_pictures: [],
      steps_attributes: %i[
        id
        order
      ],
      citations_attributes: []
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
