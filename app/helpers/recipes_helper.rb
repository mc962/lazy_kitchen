# frozen_string_literal: true

module RecipesHelper
  # Retrieves correct image url for primary_picture. If the Recipe has a primary_picture, display that, and if not,
  #   then display a default fallback image.
  #
  # @param [Recipe] recipe Recipe to check for if there is a primary_picture
  # @return [ActionView::Helpers::TagHelper::TagBuilder, ActiveSupport::SafeBuffer, NilClass]
  def primary_picture(recipe)
    classes = 'recipe-profile-img recipe-picture'
    alt_text = 'Main picture of recipe food'
    if recipe.primary_picture.attached?
      image_tag recipe.primary_picture, alt: alt_text, class: classes,
                                        data: {
                                          original_src: url_for(recipe.primary_picture),
                                          primary_picture_upload_target: 'previewImg'
                                        }
    else
      image_tag recipe_bucket_asset_url(Recipe::DEFAULT_PRIMARY_PICTURE_KEY),
                alt: alt_text,
                class: classes,
                data: {
                  original_src: recipe_bucket_asset_url(Recipe::DEFAULT_PRIMARY_PICTURE_KEY),
                  primary_picture_upload_target: 'previewImg'
                }
    end
  end
end
