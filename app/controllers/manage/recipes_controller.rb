# frozen_string_literal: true

class Manage::RecipesController < Manage::ApplicationController
  include FormRenderable
  include Imageable

  helper_method :render_frame_tab

  def index
    @recipes = Recipe.owned(current_user.id).directory(params[:page])
    authorize!

    render :index
  end

  def show
    flash.notice = 'Recipe created successfully.'

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
      if params[:deleted_resource_img_ids].present?
        purge_deleted_attachments(params[:deleted_resource_img_ids],
                                  :recipe)
      end

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
      ],
      notes_attributes: %i[
        id
        content
        _destroy
      ]
    )
  end
end
