module FormRenderable
  extend ActiveSupport::Concern

  def render_frame_tab(tab, action)
    case tab
    when 'information'
      render partial: 'application/manage/stable/recipes/information', locals: {action: action}
    when 'images'
      render partial: 'application/manage/stable/recipes/images', locals: {action: action}
    when 'steps'
      render partial: 'application/manage/stable/recipes/steps', locals: {action: action}
    when 'ingredients'
      render partial: 'application/manage/stable/recipes/ingredients', locals: {action: action}
    else
      render partial: 'application/manage/stable/recipes/information', locals: {action: action}
    end
  end
end