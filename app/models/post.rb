# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  modified_at  :date
#  published    :boolean          not null
#  published_at :date
#  slug         :string
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_posts_on_slug     (slug) UNIQUE
#  index_posts_on_title    (title) UNIQUE
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  extend FriendlyId
  include ActiveStoragePath

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_rich_text :content

  validates :title, :published, :content, :author, presence: true

  # Only bother to change published_at if `published` field will change
  before_save :set_published_at, if: :will_save_change_to_published?
  # Always set modified_at before Post is saved, but only bother if Post has been published
  before_save :set_modified_at, if: :published?

  friendly_id :title, use: %i[slugged history]

  scope :managed, -> { includes(:author) }
  scope :owned, ->(user_id) { where(user_id:) }
  scope :published, -> { where(published: true) }

  # A basic paginated list of posts, alphabetized by name, meant for a directory-like navigation of posts
  #
  # @param [ActionController::Parameters<Integer>] page Current page used to fetch correct selection of posts
  # @return [Recipe::ActiveRecord_Relation]
  def self.directory(page)
    order(:title).page(page)
  end

  private

  # Set published_at timestamp to current DateTime (UTC) only when the Post is published for the first time,
  #   as Post should only ever be published once
  def set_published_at
    self.published_at = DateTime.now.utc unless published_at?
  end

  # Sets modified_at timestamp to current DateTime (UTC) whenever a change is made to the post to track the change.
  #
  # @note Only bother to set modified_at if Post is published, as there is no need to track changes for an un-published
  #   Post.
  def set_modified_at
    self.modified_at = DateTime.now.utc
  end
end
