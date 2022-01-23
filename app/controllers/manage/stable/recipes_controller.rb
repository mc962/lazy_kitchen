class Manage::Stable::RecipesController < ApplicationController
  include FormRenderable

  helper_method :render_frame_tab

  def index
    @recipes = Recipe.directory_recipes(params[:page])

    render :index
  end

  def show
    @recipe = Recipe.friendly.find(params[:id])

    render :show
  end

  def new
    @recipe = Recipe.new

    if turbo_frame_request?
      render_frame_tab(params[:tab], manage_stable_recipes_path)
    else
      render :new
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash.notice = 'Recipe created successfully.'
      redirect_to manage_stable_recipe_path(@recipe)
    else
      flash.now[:error] = @recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe = Recipe.friendly.find(params[:id])

    if turbo_frame_request?
      render_frame_tab(params[:tab], manage_stable_recipe_path(@recipe))
    else
      render :edit
    end
  end

  def update
    @recipe = Recipe.friendly.find(params[:id])

    if @recipe.update(recipe_params)
      purge_deleted_attachments(params[:deleted_recipe_img_ids]) if params[:deleted_recipe_img_ids].present?

      flash.notice = 'Recipe updated successfully.'
      redirect_to manage_stable_recipe_path(@recipe)
    else
      flash.now[:error] = @recipe.errors.full_messages
      render :edit
    end
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
      ],
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
