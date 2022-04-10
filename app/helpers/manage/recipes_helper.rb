# frozen_string_literal: true

module Manage::RecipesHelper
  # Display text based on if Recipe is accessible to the public/wider internet
  #
  # @param [Boolean] recipe_publicly_accessible Determines if Recipe is publicly accessible based
  #   on Recipe.publicly_accessible
  # @return [String]
  def publicly_accessible_display(recipe_publicly_accessible)
    if recipe_publicly_accessible
      'Recipe is visible to the public'
    else
      'Recipe is not visible to the public'
    end
  end
end
