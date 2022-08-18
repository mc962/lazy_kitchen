# frozen_string_literal: true

class Manage::RecipesController < Manage::ApplicationController
  include Imageable
  include Tabbable

  def index
    @recipes = Recipe.owned(current_user.id).directory(params[:page])
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
      flash.notice = 'Recipe created successfully.'
      redirect_to manage_recipe_path(@recipe)
    else
      flash.now[:error] = @recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @page_edit_type = edit_type(request.path)
    if @page_edit_type == :steps
      # Editing recipe steps
      @recipe = Recipe.friendly.find(params[:recipe_id])
    elsif @page_edit_type == :recipe
      # Editing recipe information
      @recipe = Recipe.friendly.find(params[:id])
    else
      raise "Unknown edit type #{@page_edit_type}"
    end

    authorize! @recipe

    render :edit
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
