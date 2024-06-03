# frozen_string_literal: true

# Policy for ChecklistInstances
class ChecklistInstancePolicy < ApplicationPolicy
  # Restrict access to only public checklists or checklists owned/accessible by the user.
  class Scope < ApplicationPolicy::Scope
    def resolve
      user.admin? ? scope.all : restricted_scope
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
      ChecklistPolicy::Scope.new(user, Checklist).resolve.pluck(:id)
    end
  end

  def show?
    return true if record.assignee == user

    record.checklist&.container.is_a?(Workspace) &&
      WorkspacePolicy.new(user, record.checklist&.container).show?
  end
end
