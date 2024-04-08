# frozen_string_literal: true

module Workspace
  # Checklist belonging to a workspace (user or team), where actual work (checking off items, etc) is done
  class Checklist < ::Checklist
    string_enum :status, %i[open closed archived], default: :open

    belongs_to :assignee, polymorphic: true
  end
end
