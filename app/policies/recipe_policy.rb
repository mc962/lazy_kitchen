# frozen_string_literal: true

class RecipePolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def index?
    true
  end

  def new?
    true
  end

  def create?
    user.id == record.user_id ||
      user.has_any_role?(*Role::MANAGEMENT_ROLES)
  end

  def show?
    user.id == record.user_id ||
      user.has_any_role?(*Role::MANAGEMENT_ROLES)
  end

  def edit?
    user.id == record.user_id ||
      user.has_any_role?(*Role::MANAGEMENT_ROLES)
  end

  def update?
    user.id == record.user_id ||
      user.has_any_role?(*Role::MANAGEMENT_ROLES)
  end

  def destroy?
    user.id == record.user_id ||
      user.has_any_role?(*Role::MANAGEMENT_ROLES)
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end
