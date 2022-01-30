# frozen_string_literal: true

module FormRenderable
  extend ActiveSupport::Concern

  def render_frame_tab(tab, action)
    case tab
    # when 'information'
    #   render partial: 'application/manage/recipes/information', locals: { action: }
    when 'images'
      render partial: 'application/manage/recipes/images/tab', locals: { action: }
    when 'steps'
      render partial: 'application/manage/recipes/steps/all', locals: { action: }
    when 'step'
      render partial: 'application/manage/recipes/steps/full', locals: { action: }
    when 'ingredients'
      render partial: 'application/manage/recipes/steps/ingredients/all', locals: { action: }
    else
      render partial: 'application/manage/recipes/information', locals: { action: }
    end
  end
end
