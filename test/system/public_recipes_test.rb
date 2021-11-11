require "test_helper"

class AuthenticationTest < ApplicationSystemTestCase
  test 'displays recipe directory' do
    _private_recipes = FactoryBot.create_list(:recipe_with_user, 2, publicly_accessible: false)
    public_recipes = FactoryBot.create_list(:recipe_with_user, 3, publicly_accessible: true)

    visit recipes_url

    within('#directory_recipes') do
      assert page.has_selector?('li.directory-recipe', count: public_recipes.size)
    end
  end

  test 'displays individual recipe' do
    public_recipe = FactoryBot.create(:recipe_with_user, publicly_accessible: true)

    visit recipe_url(public_recipe)

    assert page.has_selector?('h1.recipe-heading', text: public_recipe.name)
  end
end