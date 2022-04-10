# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    true
  end

  def create?
    (user.has_role?(:editor) && user.id == record.author.id) ||
      user.has_any_role?(*Role::CONTENT_MANAGEMENT_ROLES)
  end

  def show?
    (user.has_role?(:editor) && user.id == record.author.id) ||
      user.has_any_role?(*Role::CONTENT_MANAGEMENT_ROLES)
  end

  def edit?
    (user.has_role?(:editor) && user.id == record.author.id) ||
      user.has_any_role?(*Role::CONTENT_MANAGEMENT_ROLES)
  end

  def update?
    (user.has_role?(:editor) && user.id == record.author.id) ||
      user.has_any_role?(*Role::CONTENT_MANAGEMENT_ROLES)
  end

  def destroy?
    (user.has_role?(:editor) && user.id == record.author.id) ||
      user.has_any_role?(*Role::CONTENT_MANAGEMENT_ROLES)
  end
end
