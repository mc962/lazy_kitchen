class Manage::Legacy::RecipesController < Manage::Legacy::ApplicationController
  def index
    @recipes = Recipe.all
    render :index
  end

  def show
    @recipe = Recipe.find(params[:id])

    render :show
  end

  def new
    @recipe = Recipe.new

    render :new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    # Associate Recipe created through Public Endpoints with currently authenticated user
    @recipe.user = current_user

    if @recipe.save
      flash.notice = 'Recipe created successfully.'
      redirect_to manage_legacy_recipe_path(@recipe)
    else
      flash.now.error = @recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])

    render :edit
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      flash.notice = 'Recipe updated successfully.'
      redirect_to manage_legacy_recipe_path(@recipe)
    else
      flash.now.error = @recipe.errors.full_messages
      render :new
    end
  end

  def destroy
    begin
      @recipe.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("Record not found with id #{params[:id]}, deletion was skipped.")
    end

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
      ]
    )
  end
end
