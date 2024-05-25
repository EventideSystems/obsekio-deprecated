# frozen_string_literal: true

module Checklists
  # Checklist model for concurrent checklists.
  #
  # Concurrent checklists may have multiple checklist instances open at any one time.
  #
  # @see Checklist
  class Concurrent < Checklist
  end
end
