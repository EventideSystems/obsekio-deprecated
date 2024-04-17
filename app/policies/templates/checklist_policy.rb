# frozen_string_literal: true

module Templates
  # Policy for Templates::Checklist
  class ChecklistPolicy < ApplicationPolicy
    # Non-admins are restricted to published checklists
    class Scope < Scope
      def resolve
        user.admin? ? scope.all : scope.where(status: 'published')
      end
    end

    def index?
      user.present?
    end

    def show?
      user.admin? || record.published?
    end

    def create?
      user.admin?
    end

    def update?
      user.admin?
    end

    def destroy?
      user.admin?
    end

    def copy_to_library?
      user.admin? || record.published?
    end

    def publish?
      user.admin? && !record.published?
    end
  end
end
