# frozen_string_literal: true

class LandingsController < ApplicationController
  MAX_HOME_RECIPES = 10

  def home
    render :home
  end

  def search
    @recipes = Search.home_autocomplete(params[:query])

    render json: @recipes
  end
end
