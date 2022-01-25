# frozen_string_literal: true

module FormRenderable
  extend ActiveSupport::Concern

  def render_frame_tab(tab, action)
    case tab
    # when 'information'
    #   render partial: 'application/manage/recipes/information', locals: { action: }
    when 'images'
      render partial: 'application/manage/recipes/images', locals: { action: }
    when 'steps'
      render partial: 'application/manage/recipes/steps', locals: { action: }
    when 'ingredients'
      render partial: 'application/manage/recipes/ingredients', locals: { action: }
    else
      render partial: 'application/manage/recipes/information', locals: { action: }
    end
  end
end
