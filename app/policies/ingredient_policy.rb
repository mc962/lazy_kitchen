# frozen_string_literal: true

class IngredientPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def index?
    true
  end

  def new?
    true
  end

  def create?
    user.id == record.user_id
  end

  def show?
    user.id == record.user_id
  end

  def edit?
    allowed_to?(:edit?, record.user_id)
  end

  def update?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end
