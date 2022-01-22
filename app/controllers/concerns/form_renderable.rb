module FormRenderable
  extend ActiveSupport::Concern

  def render_frame_tab(tab, action)
    case tab
    when 'information'
      render partial: 'application/recipes/information', locals: {action: action}
    when 'steps'
      render partial: 'application/recipes/steps', locals: {action: action}
    when 'ingredients'
      render partial: 'application/ingredients', locals: {action: action}
    else
      render partial: 'application/recipes/information', locals: {action: action}
    end
  end
end