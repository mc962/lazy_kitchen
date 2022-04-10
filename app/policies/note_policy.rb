# frozen_string_literal: true

class NotePolicy < ApplicationPolicy
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

  def edit?
    allowed_to?(:edit?, record.recipe)
  end

  def update?
    allowed_to?(:update?, record.recipe)
  end

  def destroy?
    allowed_to?(:destroy?, record.recipe)
  end
end
