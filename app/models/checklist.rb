# frozen_string_literal: true

# == Schema Information
#
# Table name: checklists
#
#  id             :uuid             not null, primary key
#  assignee_type  :string
#  container_type :string
#  content        :text
#  log_data       :jsonb
#  metadata       :jsonb
#  status         :string
#  title          :string
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  assignee_id    :uuid
#  container_id   :uuid
#  created_by_id  :uuid
#
# Indexes
#
#  index_checklists_on_assignee       (assignee_type,assignee_id)
#  index_checklists_on_container      (container_type,container_id)
#  index_checklists_on_created_by_id  (created_by_id)
#  index_checklists_on_status         (status)
#  index_checklists_on_title          (title)
#  index_checklists_on_type           (type)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#
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
