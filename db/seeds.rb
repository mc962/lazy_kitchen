# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless Rails.env.production?
  ActiveRecord::Base.transaction do
    user = FactoryBot.create(:user)
    recipes = FactoryBot.create_list(:recipe, 5, user: user)
    ingredients = FactoryBot.create_list(:ingredient, 10, user: user)

    recipes.each do |recipe|
      steps = FactoryBot.create_list(:step, 10, recipe: recipe)

      steps.each do |step|
        selected_ingredients = ingredients.take(3)
        selected_ingredients.each do |ingredient|
          FactoryBot.create(:step_ingredient, step: step, ingredient: ingredient)
        end
      end
    end
  end
end
