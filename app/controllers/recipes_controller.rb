class RecipesController < ApplicationController
  def create; end

  def index
    @recipes = Recipe.publicly_accessible

    render :index
  end

  def show
    @recipe = Recipe.publicly_accessible.find(params[:id])

    render :show
  end
end
