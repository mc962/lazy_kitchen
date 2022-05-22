class Search
  # Queries data store for data matching complex Search queries
  # Currently implemented using PostgreSQL Text Search features
  #
  # @param [String] query User-inputted search query
  # @return [Array<Recipe>]
  def self.home_autocomplete(query)
    Recipe.search_by_name(query)
  end
end