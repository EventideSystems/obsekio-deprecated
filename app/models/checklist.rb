# frozen_string_literal: true

# Base class for all checklists.

# == Schema Information
#
# Table name: checklists
#
#  id                                 :uuid             not null, primary key
#  assignee_type                      :string
#  content                            :text
#  data_entry_checkbox_checked_color  :string           default("green"), not null
#  data_entry_comments                :string           default(NULL), not null
#  data_entry_input_type              :string           default("checkbox"), not null
#  data_entry_radio_additional_states :jsonb
#  data_entry_radio_primary_color     :string           default("green"), not null
#  data_entry_radio_primary_text      :string
#  data_entry_radio_secondary_color   :string           default("amber"), not null
#  data_entry_radio_secondary_text    :string
#  instance_model_name                :string           default("Instance"), not null
#  log_data                           :jsonb
#  metadata                           :jsonb
#  owner_type                         :string
#  status                             :string
#  title                              :string
#  type                               :string
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  assignee_id                        :uuid
#  owner_id                           :uuid
#
# Indexes
#
#  index_checklists_on_assignee  (assignee_type,assignee_id)
#  index_checklists_on_owner     (owner_type,owner_id)
#  index_checklists_on_status    (status)
#  index_checklists_on_title     (title)
#  index_checklists_on_type      (type)
#
class Checklist < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper

  has_logidze

  string_enum :status, %i[draft published ready in_progress complete archived], default: :draft
  string_enum :data_entry_comments, %i[disallowed allowed prompt required], default: :disallowed

  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :assignee, polymorphic: true, optional: true
  belongs_to :owner, polymorphic: true

  has_many :checklist_instances, dependent: :destroy

  validates :title, presence: true
  validates :instance_model_name, presence: true

  attribute :data_entry_radio_additional_states, ActiveModelListType.new(DataEntryRadioAdditionalState)

  # attribute :item_state_definitions, ActiveModelListType.new(ChecklistItemStateDefinition)

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

  # Returns the base color (red, blue, fuschia, etc) for the state of an item
  # @param state [String]
  # @return [String]
  def base_color_for_state(state)
    return 'gray' if state.blank?

    case data_entry_input_type.to_sym
    when :radio then base_color_for_radio_state(state)
    when :radio_dialog_plus_comments then base_color_for_radio_state(state)
    when :checkbox then base_color_for_checkbox_state(state)
    else
      'gray'
    end
  end

  # Returns the items, and their base state, in the checklist. Used to prime checklist instances
  # @return [Array<ChecklistItem>]
  def items
    return [] if content.blank?

    # default_item_state_definition = item_state_definitions.find(&:default)

    content.scan(/^[-|*] \[(.)\] (.*)/).map do |checked, text|
      ChecklistItem.new(
        # TODO: Change this to support more than just checked and unchecked states
        state: checked.present? ? 'checked' : 'unchecked',
        text: strip_tags(text)
      )
    end
  end

  private

  def base_color_for_radio_state(state)
    return data_entry_radio_primary_color if state == data_entry_radio_primary_text
    return data_entry_radio_secondary_color if state == data_entry_radio_secondary_text

    data_entry_radio_additional_states.find { |s| s.text == state }&.color || 'gray'
  end
end
