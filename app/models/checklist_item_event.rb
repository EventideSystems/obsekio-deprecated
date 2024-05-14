# frozen_string_literal: true

# Represents an event that occurred on a checklist item
class ChecklistItemEvent < ApplicationRecord
  belongs_to :checklist_instance

  validates :checklist_instance, presence: true
  validates :index, presence: true
  validates :item_state, presence: true

  after_create :update_checklist_instance

  private

  def update_checklist_instance
    checklist_instance.update_checklist_item(event: self)
  end
end
