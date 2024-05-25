# frozen_string_literal: true

# Represents an instance, or run through, of a checklist
class ChecklistInstance < ApplicationRecord
  has_logidze

  belongs_to :checklist
  belongs_to :assignee, polymorphic: true, optional: true
  has_many :checklist_item_events, dependent: :destroy

  validates :checklist, presence: true

  string_enum :status, %i[ready in_progress complete archived], default: :ready

  delegate :content, to: :checklist

  def prepare_items
    return if item_states.present?

    self.item_states = checklist.items.map do |checklist_item|
      { text: checklist_item.text, checked: checklist_item.checked }
    end
  end

  def items
    build_items
  end

  def update_checklist_item(event:)
    prepare_items if item_states[event.index].blank?

    item_states[event.index] = item_states[event.index].merge(event.item_state)

    save!
  end

  private

  def build_items
    item_states.map do |item_state|
      ChecklistItem.new(item_state.slice(*%w[checked text]))
    end
  end
end
