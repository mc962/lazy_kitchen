module Manage::RecipesHelper
  def publicly_accessible_display(recipe_publicly_accessible)
    if recipe_publicly_accessible
      'Recipe is visible to the public'
    else
      'Recipe is not visible to the public'
    end
  end
end
