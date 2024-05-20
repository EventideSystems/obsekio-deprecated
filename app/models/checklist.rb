# frozen_string_literal: true

# Base class for checklist models.
# NOTE: This is an abstract class and should not be used directly.
#
# @abstract
# @see Checklists::Single
class Checklist < ApplicationRecord
  has_logidze
  include ActionView::Helpers::SanitizeHelper

  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :assignee, polymorphic: true, optional: false

  has_many :checklist_instances, dependent: :destroy

  # Returns the items in the checklist.
  # @return [Array<ChecklistItem>]
  def items
    content.scan(/^[-|*] \[(.)\] (.*)/).map do |checked, text|
      ChecklistItem.new(
        checked: checked.present?,
        text: strip_tags(text)
      )
    end
  end
end
