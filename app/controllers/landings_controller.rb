class LandingsController < ApplicationController
  def home
    @recipes = Recipe.root_recipes

    render :home
  end
end
