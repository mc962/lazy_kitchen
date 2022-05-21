# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.publicly_accessible.directory(params[:page])

    render :index
  end

  def show
    @recipe = Recipe.publicly_accessible.managed.friendly.find(params[:id])

    render :show
  end

  def search
    @recipes = Recipe
  end
end
