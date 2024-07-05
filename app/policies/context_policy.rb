# frozen_string_literal: true

# Policy for Contexts
class ContextPolicy < ApplicationPolicy
  # Non-admins are restricted to contexts within their workspace
  class Scope < Scope
    def resolve
      user_context.admin? ? scope.all : restricted_scope
    end

    # List of contexts that are within the user's workspace
    # TODO: Move this into the User model as a scope
    # TODO: This is a placeholder for the actual implementation
    def restricted_scope
      scope.where(workspace_id: accessible_workspace_ids)
    end
  end
end
