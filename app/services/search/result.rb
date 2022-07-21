module Search
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