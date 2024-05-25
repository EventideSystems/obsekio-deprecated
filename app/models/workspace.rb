# frozen_string_literal: true

# Workspace model, a container for checklists and other resources.
class Workspace < ApplicationRecord
  belongs_to :owner, polymorphic: true

  has_many :checklists, class_name: 'Checklist', inverse_of: :container, dependent: :destroy
end
