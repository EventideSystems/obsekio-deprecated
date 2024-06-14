# frozen_string_literal: true

# Policy for ChecklistInstances
class ChecklistInstancePolicy < ApplicationPolicy
  # Restrict access to only public checklists or checklists owned/accessible by the user.
  class Scope < ApplicationPolicy::Scope
    def resolve
      user_context.admin? ? scope.all : restricted_scope
    end

    # List of checklists that are published and public, or were created by the user
    # TODO: Move this into the model as a scope
    def restricted_scope
      # Restrict the scope to ChecklistInstances that belong to those Checklists
      scope.where(checklist_id: accessible_checklist_ids)
    end

    private

    # Get the IDs of the Checklists the user has access to
    def accessible_checklist_ids
      ChecklistPolicy::Scope.new(user_context, Checklist).resolve.pluck(:id)
    end
  end

  def create?
    return true if record.checklist.assignee == user_context.user

    ChecklistPolicy.new(user_context, record.checklist).update?
  end

  def show?
    return true if record.assignee == user_context.user

    record.checklist&.container.is_a?(Workspace) &&
      WorkspacePolicy.new(user_context, record.checklist&.container).show?
  end

  def update_items?
    return true if record.assignee == user_context.user

    record.checklist&.container.is_a?(Workspace) &&
      WorkspacePolicy.new(user_context, record.checklist&.container).update?
  end
end
