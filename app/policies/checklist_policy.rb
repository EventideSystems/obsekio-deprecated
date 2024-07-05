# frozen_string_literal: true

# Policy for Checklists
class ChecklistPolicy < ApplicationPolicy
  # Non-admins are restricted to published checklists
  class Scope < Scope
    def resolve
      user_context.admin? ? scope.all : restricted_scope
    end

    def restricted_scope
      # Restrict to Checklists that belong to the current user or are assigned to the user
      scope.where(owner: user_context.user)
           .or(scope.where(assignee_type: 'User', assignee_id: user_context.id))
    end
  end

  PERMITTED_ATTRIBUTES = %i[
    content
    title
    metadata
    name
    description
    author_name
    license
  ].freeze

  def permitted_attributes
    PERMITTED_ATTRIBUTES
  end

  def index?
    user_context.present?
  end

  def show?
    admin_or_owner? || published_and_public?
  end

  def create?
    user_context.present?
  end

  def update?
    admin_or_owner?
  end

  def destroy?
    admin_or_owner?
  end

  def personal?
    admin_or_owner?
  end

  def details?
    update?
  end

  def copy_to_workspace?
    admin_or_owner? || published_and_public?
  end

  def publish?
    admin_or_owner? # && !record.published?
  end

  private

  def admin_or_owner?
    user_context.admin? || record.owner == user_context.user
  end

  def published_and_public?
    record.published? && record.public?
  end
end
