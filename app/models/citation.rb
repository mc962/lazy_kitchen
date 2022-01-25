# frozen_string_literal: true

# == Schema Information
#
# Table name: citations
#
#  id                   :integer          not null, primary key
#  origin               :string           not null
#  content_type         :string           not null
#  publication_title    :string
#  publication_location :string
#  publisher            :string
#  published_at         :date
#  content_location     :string
#  version              :string
#  site_title           :string
#  last_accessed_at     :date
#  site_link            :string
#  recipe_id            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_citations_on_recipe_id  (recipe_id)
#

# Handles data for any citations that need to be cited as having contributed in some way to the Recipe.
#   In general, citations will follow and be displayed in the _`Modern Language Association`_ (*MLA*) format.
class Citation < ApplicationRecord
  CONTENT_TYPES = %w[SITE BOOK].freeze
  ORIGINS = %w[ADAPTED INSPIRED ORIGINAL].freeze

  belongs_to :recipe
  has_many :authors, lambda {
    # Citation's authors should be displayed sorted by last_name, first_name
    order(last_name: :asc, first_name: :asc)
  }

  # default_scope { includes(:authors) }

  validates :recipe, presence: true

  validates :content_type, inclusion: { in: CONTENT_TYPES }
  validates :origin, inclusion: { in: ORIGINS }

  accepts_nested_attributes_for :authors

  scope :managed, -> { includes(recipe: [:user]) }

  # Generates an MLA-formatted Citation String, with exact output depending on type of content being cited
  #
  # @todo This should probably be done in a partial instead
  # @return [ActiveSupport::SafeBuffer]
  # @raise [StandardError]
  def generate
    case content_type
    when 'SITE'
      site_citation
    when 'BOOK'
      book_citation
    else
      raise "Unknown type #{content_type}"
    end
  end

  private

  # Generates an MLA-formatted citation for web site based media
  #
  # @return [ActiveSupport::SafeBuffer]
  def site_citation
    citation = ''

    citation << ("#{authors.join(', ')}. ") if authors

    citation << %("#{publication_title}" ) if publication_title

    if site_title
      italicized_title = "<em>#{site_title}</em>, ".html_safe
      citation << italicized_title
    end

    citation << "#{site_link}." if site_link

    citation << "#{last_accessed_at}." if last_accessed_at

    citation.html_safe
  end

  # Generates an MLA-formatted citation for print/book based media
  #
  # @return [ActiveSupport::SafeBuffer]
  def book_citation
    citation = ''

    citation << ("#{authors.join(', ')}. ") if authors

    if publication_title
      italicized_title = "<em>#{publication_title}</em>. ".html_safe
      citation << italicized_title
    end

    citation << "#{publication_location}: " if publication_location

    citation << "#{publisher}, " if publisher

    citation << "#{published_at.year}. "

    citation.html_safe
  end
end
