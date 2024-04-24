# frozen_string_literal: true

module Library
  # Checklist belonging to the library
  class Checklist < ApplicationRecord
    has_markdown :content

    string_enum :status, %i[draft published archived], default: :draft

    validates :title, presence: true

    belongs_to :created_by, class_name: 'User', optional: true
  end
end
