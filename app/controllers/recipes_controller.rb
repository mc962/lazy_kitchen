class RecipesController < ApplicationController
  def create; end

  def index
    @recipes = Recipe.all

    render :index
  end

  def show
    @recipe = Recipe.find(params[:id])

    render :show
  end

  def update; end

  def destroy; end
end
