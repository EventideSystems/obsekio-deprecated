# frozen_string_literal: true

module Library
  # Sample view model for public checklists, which is a read-only view of the checklists that are shared across
  # the application.
  #
  # NOTE: This is just to test that scenic is working and not impacted by the logidze or fx gems
  class PublicChecklist < ApplicationRecord
    def readonly? = true
  end
end
