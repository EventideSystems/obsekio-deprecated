# frozen_string_literal: true

# == Schema Information
#
# Table name: checklist_instances
#
#  id            :uuid             not null, primary key
#  assignee_type :string
#  item_states   :jsonb            is an Array
#  log_data      :jsonb
#  status        :string           default("ready"), not null
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assignee_id   :uuid
#  checklist_id  :uuid             not null
#
# Indexes
#
#  index_checklist_instances_on_assignee      (assignee_type,assignee_id)
#  index_checklist_instances_on_checklist_id  (checklist_id)
#
# Foreign Keys
#
#  fk_rails_...  (checklist_id => checklists.id)
#
class ChecklistInstance < ApplicationRecord
  has_logidze

  belongs_to :checklist
  belongs_to :assignee, polymorphic: true, optional: true
  has_many :checklist_item_events, dependent: :destroy

  validates :checklist, presence: true

  string_enum :status, %i[ready in_progress complete archived], default: :ready

  delegate :content, :instance_model_name, to: :checklist
  delegate :data_entry_input_type, :data_entry_checkbox_checked_color, :data_entry_comments, to: :checklist

  delegate :data_entry_radio_primary_text, :data_entry_radio_primary_color, to: :checklist
  delegate :data_entry_radio_secondary_text, :data_entry_radio_secondary_color, to: :checklist
  delegate :data_entry_radio_additional_states, to: :checklist

  after_save :prepare_items

  def prepare_items
    return if item_states.present?

    case data_entry_input_type.to_sym
    when :checkbox
      prepare_items_for_checkbox
    when :radio
      prepare_items_for_radio
    end
  end

  def items
    build_items
  end

  # TODO: Add a guard condition to prevent updating the items if the checklist is not in progress / ready
  def update_checklist_item(event:)
    if item_states[event.index].blank?
      prepare_items
      save!
    end

    ActiveRecord::Base.connection.execute(update_checklist_item_sql(event))
  end

  private

  def build_items
    item_states.map do |item_state|
      ChecklistItem.new(item_state.slice(*%w[state text]))
    end
  end

  def prepare_items_for_checkbox
    self.item_states = checklist.items.map do |checklist_item|
      { text: checklist_item.text, state: checklist_item.state }
    end
  end

  def prepare_items_for_radio
    self.item_states = checklist.items.map do |checklist_item|
      state = checklist_item.state == 'checked' ? data_entry_radio_primary_text : checklist_item.state
      { text: checklist_item.text, state: }
    end
  end

  # NOTE: Postgres arrays are 1-indexed
  def update_checklist_item_sql(event)
    <<~SQL
      update checklist_instances
      set item_states[#{event.index + 1}] = '#{event.item_state.to_json}'
      where id = '#{id}'
    SQL
  end
end
