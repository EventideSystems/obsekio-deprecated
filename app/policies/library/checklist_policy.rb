# frozen_string_literal: true

module Library
  # Policy for Library::Checklist
  class ChecklistPolicy < ApplicationPolicy
    # Non-admins are restricted to published checklists
    class Scope < Scope
      def resolve
        user.admin? ? scope.all : restricted_scope
      end

      # List of checklists that are published and public, or were created by the user
      # TODO: Move this into the model as a scope
      def restricted_scope
        scope.where(status: 'published', public: true).or(scope.where(created_by: user))
      end
    end

    PERMITTED_ATTRIBUTES = %i[
      content
      contributor
      creator
      description
      format
      public
      language
      publisher
      rights
      source
      status
      title
      title_alternative
    ].freeze

    def permitted_attributes
      PERMITTED_ATTRIBUTES
    end

    def index?
      user.present?
    end

    def show?
      admin_or_created_by_user? || published_and_public?
    end

    def create?
      user.present?
    end

    def update?
      admin_or_created_by_user?
    end

    def destroy?
      admin_or_created_by_user?
    end

    def copy_to_workspace?
      admin_or_created_by_user? || published_and_public?
    end

    def publish?
      admin_or_created_by_user? && !record.published?
    end

    private

    def admin_or_created_by_user?
      user.admin? || record.created_by == user
    end

    def published_and_public?
      record.published? && record.public?
    end
  end
end
