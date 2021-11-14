# frozen_string_literal: true

class StepIngredientPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def index?
    true
  end

  def new?
    true
  end

  def create?
    allowed_to?(:create?, record.step) && allowed_to?(:create?, record.ingredient)
  end

  def show?
    allowed_to?(:show?, record.step)
  end

  def edit?
    allowed_to?(:edit?, record.step)
  end

  def update?
    allowed_to?(:update?, record.step) && allowed_to?(:update?, record.ingredient)
  end

  def destroy?
    allowed_to?(:destroy?, record.step)
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end
