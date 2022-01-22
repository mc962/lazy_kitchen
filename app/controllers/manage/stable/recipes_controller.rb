class Manage::Stable::RecipesController < ApplicationController
  include FormRenderable

  helper_method :render_frame_tab

  def index
    @recipes = Recipe.directory_recipes(params[:page])

    render :index
  end

  def show
    @recipe = Recipe.find(params[:id])

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
    @recipe = Recipe.find(params[:id])

    if turbo_frame_request?
      render_frame_tab(params[:tab], manage_stable_recipe_path(@recipe))
    else
      render :edit
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
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
      steps_attributes: %i[
        id
        order
        instruction
        _destroy
      ],
      )
  end
end
