# frozen_string_literal: true

module Templates
  # Checklist belonging to the template collection
  class Checklist < ::Checklist
    string_enum :status, %i[draft published archived], default: :draft
  end
end
