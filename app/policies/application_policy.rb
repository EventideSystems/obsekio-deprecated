# frozen_string_literal: true

# Base class for all policies
class ApplicationPolicy
  attr_reader :user_context, :record

  def initialize(user_context, record)
    @user_context = user_context
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new? = create?

  def update?
    false
  end

  def edit? = update?

  def destroy?
    false
  end

  # Base class for all policy scopes
  class Scope
    attr_reader :user_context, :scope

    def initialize(user_context, scope)
      @user_context = user_context
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    def accessible_workspace_ids
      WorkspacePolicy::Scope.new(user_context, Workspace).resolve.pluck(:id)
    end

    def accessible_library_ids
      LibraryPolicy::Scope.new(user_context, Library).resolve.pluck(:id)
    end
  end
end
