module FormRenderable
  extend ActiveSupport::Concern

  def render_frame_tab(tab, action)
    case tab
    when 'information'
      render partial: 'application/manage/recipes/information', locals: {action: action}
    when 'images'
      render partial: 'application/manage/recipes/images', locals: {action: action}
    when 'steps'
      render partial: 'application/manage/recipes/steps', locals: {action: action}
    when 'ingredients'
      render partial: 'application/manage/recipes/ingredients', locals: {action: action}
    else
      render partial: 'application/manage/recipes/information', locals: {action: action}
    end
  end
end