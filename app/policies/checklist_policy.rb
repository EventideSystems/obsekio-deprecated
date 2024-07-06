# frozen_string_literal: true

# Policy for Checklists
class ChecklistPolicy < ApplicationPolicy
  # Non-admins are restricted to published checklists
  class Scope < Scope
    def resolve
      user_context.admin? ? scope.all : restricted_scope
    end

    # List of checklists that are published and public, or were created by the user
    # TODO: Move this into the model as a scope
    def restricted_scope
      # Restrict the scope to Checklists that belong to those Workspaces and Libraries,
      # or are assigned to the user
      scope.where(container_type: 'Workspace', container_id: accessible_workspace_ids)
           .or(scope.where(container_type: 'Library', container_id: accessible_library_ids))
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
    admin_or_created_by_user? || published_and_public?
  end

  def create?
    user_context.present?
  end

  def update?
    admin_or_created_by_user?
  end

  def destroy?
    admin_or_created_by_user?
  end

  def personal?
    admin_or_created_by_user?
  end

  def details?
    update?
  end

  def copy_to_workspace?
    admin_or_created_by_user? || published_and_public?
  end

  def publish?
    admin_or_created_by_user? # && !record.published?
  end

  private

  def admin_or_created_by_user?
    user_context.admin? || record.created_by == user_context.user
  end

  def published_and_public?
    record.published? && record.public?
  end
end
