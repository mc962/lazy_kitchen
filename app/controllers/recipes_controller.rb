# frozen_string_literal: true

class RecipesController < ApplicationController
  def create; end

  def index
    @recipes = Recipe.publicly_accessible

    render :index
  end

  def show
    @recipe = Recipe.publicly_accessible.friendly.find(params[:id])

    render :show
  end
end
