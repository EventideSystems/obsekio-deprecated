# frozen_string_literal: true

# Base class for checklist models.
# NOTE: This is an abstract class and should not be used directly.
#
# @abstract
# @see Checklists::Single
class Checklist < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper

  has_logidze

  string_enum :status, %i[draft published ready in_progress complete archived], default: :draft

  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :assignee, polymorphic: true, optional: true
  belongs_to :container, polymorphic: true, optional: true

  has_many :checklist_instances, dependent: :destroy

  validates :title, presence: true

  # Mapping of basic metadata. The actual metadata is stored in the metadata column
  #
  # We assume that the metadata conforms to the schema.org CreativeWork type
  # @see https://schema.org/CreativeWork
  #
  # These accessors / attributes are only for convenience when working with the metadata
  # in forms. It may be better to use a form object or delegate to a presenter object
  store_accessor :metadata, :name, :description, :author, :license
  attribute :author, :jsonb, default: { '@type': 'Person', name: '' }
  store_accessor :author, :name, prefix: true

  # Returns the items in the checklist.
  # @return [Array<ChecklistItem>]
  def items
    return [] if content.blank?

    content.scan(/^[-|*] \[(.)\] (.*)/).map do |checked, text|
      ChecklistItem.new(
        checked: checked.present?,
        text: strip_tags(text)
      )
    end
  end
end
