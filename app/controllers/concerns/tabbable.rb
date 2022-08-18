module Tabbable
  include ActiveSupport::Concern

  def edit_type(path)
    if path.ends_with?('/steps/edit')
      :steps
    else
      :recipe
    end
  end
end