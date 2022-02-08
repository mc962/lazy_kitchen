# frozen_string_literal: true

class API::RecipePolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end
end
