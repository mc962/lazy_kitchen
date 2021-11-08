class Manage::Legacy::RecipesController < Manage::Legacy::ApplicationController
  def index
    # Only show recipes for management owned by current user (including private recipes, so remove default `publicly_accessible` scope)
    @recipes = Recipe.where(user_id: current_user.id).all
    authorize!

    render :index
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.where(user_id: current_user.id).find(params[:id])
    authorize! @recipe

    render :edit
  end

  def update
    @recipe = Recipe.where(user_id: current_user.id).find(params[:id])
    authorize! @recipe

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
    @recipe = Recipe.where(id: params[:id], user_id: current_user.id)
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
      steps_attributes: [
        :id,
        :order
      ],
      citations_attributes: []
    )
  end
end
