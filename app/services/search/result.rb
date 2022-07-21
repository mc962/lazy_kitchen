# frozen_string_literal: true

module Search
  # A common interface for results returned from search service
  class Result
    include ActiveModel::API

    Image = Struct.new(:item, :alt)

    # @return [Object]
    attr_accessor :reference
    # @return [String]
    attr_accessor :title
    # @return [Search::Result::Image]
    attr_accessor :image

    validates :title, :image, presence: true
  end
end
