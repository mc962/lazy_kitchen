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

    @recipe.primary_picture.attach(
      key: "#{RESOURCE_BUCKET_PREFIX}/recipes/#{recipe_params[:primary_picture].original_filename}",
      io: recipe_params[:primary_picture],
      content_type: recipe_params[:primary_picture].content_type,
      filename: recipe_params[:primary_picture].original_filename
    )
    # @recipe.primary_picture.attach(params[:primary_picture])

    # Associate Recipe created through Public Endpoints with currently authenticated user
    # @recipe.user = current_user

    if @recipe.update(recipe_params)
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
      steps_attributes: %i[
        id
        order
      ],
      citations_attributes: []
    )
  end
end
