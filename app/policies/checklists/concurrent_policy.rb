# frozen_string_literal: true

module Checklists
  # Policy for Checklists::Concurrent
  class ConcurrentPolicy < ::ChecklistPolicy
    # Inherit from ChecklistPolicy
    class Scope < ::ChecklistPolicy::Scope
    end
  end
end
