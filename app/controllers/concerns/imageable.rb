# frozen_string_literal: true

module Imageable
  extend ActiveSupport::Concern

  def purge_deleted_attachments(deleted_attachment_ids, record_type)
    case record_type
    when :recipe
      purge_recipe_attachments(deleted_attachment_ids)
    when :step
      purge_step_attachments(deleted_attachment_ids)
    when :ingredient
      purge_ingredient_attachments(deleted_attachment_ids)
    else
      raise "Unknown attachment record type: #{record_type}"
    end
  end

  def purge_recipe_attachments(deleted_attachment_ids)
    attachments = ActiveStorage::Attachment
                  .where(id: deleted_attachment_ids, record_type: 'Recipe')
                  .joins('JOIN recipes ON active_storage_attachments.record_id = recipes.id')
                  .joins('JOIN users ON recipes.user_id = users.id')
                  .where('users.id = ?', current_user.id)
    attachments.map(&:purge)
  end

  def purge_step_attachments(deleted_attachment_ids)
    attachments = ActiveStorage::Attachment
                  .where(id: deleted_attachment_ids, record_type: 'Step')
                  .joins('JOIN steps ON active_storage_attachments.record_id = steps.id')
                  .joins('JOIN recipes ON steps.step_id = recipes.id')
                  .joins('JOIN users ON recipes.user_id = users.id')
                  .where('users.id = ?', current_user.id)
    attachments.map(&:purge)
  end

  def purge_ingredient_attachments(deleted_attachment_ids)
    attachments = ActiveStorage::Attachment
                  .where(id: deleted_attachment_ids, record_type: 'Ingredient')
                  .joins('JOIN ingredients ON active_storage_attachments.record_id = ingredients.id')
                  .joins('JOIN users ON ingredients.user_id = users.id')
                  .where('users.id = ?', current_user.id)
    attachments.map(&:purge)
  end
end
