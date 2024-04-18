# frozen_string_literal: true

module Templates
  # Checklist belonging to the template collection
  class Checklist < ApplicationRecord
    has_markdown :content

    string_enum :status, %i[draft published archived], default: :draft

    validates :title, presence: true
  end
end
