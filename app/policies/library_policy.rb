# frozen_string_literal: true

# LibraryPolicy restricts access to libraries based on the user's role.
class LibraryPolicy < ApplicationPolicy
  # Restrict access to only public libraries or libraries owned by the user.
  # NOTE: we will need to extend this once 'teams' are implemented.
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.public_libraries.or(scope.where(owner: user_context.user))
    end
  end

  def show?
    record.owner == user_context.user || record.public?
  end

  def personal?
    record.owner == user_context.user
  end

  def create_checklist?
    record.owner == user_context.user
  end
end
