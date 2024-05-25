# frozen_string_literal: true

module Checklists
  # Policy for Checklists::Single
  class SinglePolicy < ::ChecklistPolicy
    # Non-admins are restricted to published checklists
    class Scope < Scope
      def resolve
        user.admin? ? scope.all : restricted_scope
      end

      # List of checklists that are published and public, or were created by the user
    end
  end
end
