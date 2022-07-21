# frozen_string_literal: true

module Search
  # Service client for interacting with Search data store
  class Client
    # Queries data store for data matching complex Search queries
    # Currently implemented using PostgreSQL Text Search features
    #
    # @param [String] query Search term to attempt to find matching recipes on
    # @param [Integer] page Current page of results to return
    # @return [Search::ResultSet]
    def self.recipes(query, page: 1)
      if query.present?
        recipes = Recipe.search(query:, page:)
        results = recipes.map do |recipe|
          Search::Result.new(
            reference: recipe,
            title: recipe.name,
            image: Search::Result::Image.new(
              (recipe.primary_picture.attached? ? recipe.primary_picture : nil),
              'Main picture of recipe food'
            )
          )
        end
        Search::ResultSet.new(
          results
        )
      else
        Recipe.none
      end
    end
  end
end
