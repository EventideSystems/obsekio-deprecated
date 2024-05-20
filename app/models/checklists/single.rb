# frozen_string_literal: true

module Checklists
  # Checklist model for single instance checklists.
  #
  # Single instance checklists are checklists that have only one instance.
  #
  # @see Checklist
  class Single < Checklist
    # Returns the single instance of the checklist.
    #
    # If the checklist is not a single instance checklist, it returns nil.
    #
    # If no instance record exists, it creates a new instance automatically.
    #
    # @return [ChecklistInstance, nil]
    def single_instance
      checklist_instances.first || create_single_instance
    end

    private

    # SMELL: Not entirely sure having a method that creates new records as a side effect is a good idea. We should
    # consider refactoring this and moving the setup for instances outside of the checklist model.
    def create_single_instance
      checklist_instance = checklist_instances.create(assignee:)
      checklist_instance.prepare_items
      checklist_instance.save!

      checklist_instance
    end
  end
end
