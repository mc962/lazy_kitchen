# frozen_string_literal: true

module Manage::Legacy::StepsHelper
  # Get potential order of current step, based on number of existing steps on recipe (assumes steps are added to the end),
  #   when adding a new step.
  #   If step already exists, then simply use that step's order value.
  #
  # @param [Recipe]
  # @return [Integer]
  def new_step_order(form_action, existing_step_order, recipe)
    case form_action
    when :post
      recipe.steps.size + 1
    when :patch
      existing_step_order
    else
      raise "Unknown action: #{form_action}"
    end
  end
end
