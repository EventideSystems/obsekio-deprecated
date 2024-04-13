# frozen_string_literal: true

# Base class for checklist models.
# NOTE: This is an abstract class and should not be used directly.
#
# @abstract
# @see Library::Checklist
# @see Templates::Checklist
class Checklist < ApplicationRecord
  include StringEnum
  has_markdown :content

  string_enum :instance_model, %i[single longitudinal concurrent], default: :single

  has_many :checklist_instances, dependent: :destroy

  # Returns the single instance of the checklist.
  #
  # If the checklist is not a single instance checklist, it returns nil.
  #
  # If no instance record exists, it creates a new instance automatically.
  #
  # @return [ChecklistInstance, nil]
  def single_instance
    return nil unless single?

    checklist_instances.first || create_single_instance
  end

  private

  # SMELL: Not entirely sure having a method that creates new records as a side effect is a good idea. We should
  # consider refactoring this and moving the setup for instances outside of the checklist model.
  def create_single_instance
    checklist_instances.create(content:)
  end
end
