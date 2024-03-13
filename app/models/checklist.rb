# frozen_string_literal: true

# Represents a checklist
class Checklist < ApplicationRecord
  validates :title, presence: true

  def convert_to_html; end
end
