# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.has_any_role?(*Role::MANAGEMENT_ROLES)
  end

  def show?
    user.id == record.id ||
      user.has_any_role?(*Role::MANAGEMENT_ROLES)
  end

  def destroy?
    user.id == record.id ||
      (user.has_any_role?(*Role::MANAGEMENT_ROLES) && !record.has_role?(:superuser))
  end
end
