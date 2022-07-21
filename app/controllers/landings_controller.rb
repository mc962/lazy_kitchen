# frozen_string_literal: true

class LandingsController < ApplicationController
  MAX_HOME_RECIPES = 10

  def index
    render :index
  end
end
