class AuthorPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def index?
    true
  end

  def new?
    true
  end

  def create?
    allowed_to?(:create?, record.citation)
  end

  def show?
    record.present? && allowed_to?(:show?, record.citation)
  end

  def update?
    allowed_to?(:update?, record.citation)
  end

  def destroy?
    allowed_to?(:destroy?, record.citation)
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end
