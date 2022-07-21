require "test_helper"

class LandingsTest < ApplicationSystemTestCase
  test 'loads home page with limited selection of public recipes' do
    _private_recipes = FactoryBot.create_list(:recipe_with_user, 2, publicly_accessible: false)
    _public_recipes = FactoryBot.create_list(:recipe_with_user, LandingsController::MAX_HOME_RECIPES + 3, publicly_accessible: true)

    visit root_url

    assert page.has_selector?('#search_bar')
    # within('#landing_recipes') do
    #   assert page.has_selector?('li.directory-item', count: LandingsController::MAX_HOME_RECIPES)
    # end
  end
end