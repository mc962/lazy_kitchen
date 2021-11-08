class StepPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def index?
    true
  end

  def new?
    true
  end

  def create?
    allowed_to?(:create?, record.recipe)
  end

  def show?
    allowed_to?(:show?, record.recipe)
  end

  def update?
    allowed_to?(:update?, record.recipe)
  end

  def destroy?
    allowed_to?(:destroy?, record.recipe)
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end
