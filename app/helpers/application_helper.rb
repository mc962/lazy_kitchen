# frozen_string_literal: true

module ApplicationHelper

  # Generates link to an S3 bucket url based on a given S3 Object key
  #
  # @param [String] s3_key A key pointing to an object in S3 (not including the bucket name prefix)
  # @note Keys should generally not have a leading '/' in the key.
  # @return [String]
  def recipe_bucket_asset_url(s3_key)
    "https://#{LAZY_KITCHEN_BUCKET}.s3.amazonaws.com/#{s3_key}"
  end
end
