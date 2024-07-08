# frozen_string_literal: true

# WorkspacePolicy restricts access to workspaces based on the user's role.
class WorkspacePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  # Restrict workspace access to the owner.
  # NOTE: we will need to extend this once 'teams' are implemented.
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(owner: user_context.user)
    end
  end

  def show?
    record.owner == user_context.user
  end

  def update?
    show?
  end

  def personal?
    show?
  end

  def create_checklist?
    record.owner == user_context.user
  end

  def settings?
    show?
  end
end
