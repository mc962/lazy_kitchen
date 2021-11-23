# frozen_string_literal: true

module ApplicationHelper
  # Generates link to an S3 bucket url based on a given S3 Object key
  #
  # @param [String] s3_key A key pointing to an object in S3 (not including the bucket name prefix)
  # @note Keys should generally not have a leading '/' in the key.
  # @note Constructed manually instead of through ActiveStorage because this image is not tied to a real model
  # @return [String]
  def recipe_bucket_asset_url(s3_key)
    "https://#{Rails.configuration.x.application_bucket}.s3.amazonaws.com/#{s3_key}"
  end
end
