class LandingsController < ApplicationController
  def home
    @recipes = Recipe.all

    render :home
  end
end
