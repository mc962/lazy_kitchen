# frozen_string_literal: true

module Search
  # Array-like data structure for results returned from Search service
  class ResultSet
    include Enumerable

    delegate :each, :<<, :push, :pop, :size, :length, :[], to: :items

    # @return [Array<Search::Result>]
    attr_accessor :items

    # @param [Array<Search::Result>, ActiveRecord::Relation, NilClass] initial Initial data to seed ResultSet with
    def initialize(initial)
      @items = initial || []
    end
  end
end
