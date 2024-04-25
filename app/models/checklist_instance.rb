# frozen_string_literal: true

# Represents an instance, or run through, of a checklist
class ChecklistInstance < ApplicationRecord
  belongs_to :checklist
  belongs_to :assignee, polymorphic: true, optional: true

  def checklist_items
    @checklist_items ||= ChecklistItemsParser.new(content).parse
  end

  def update_checklist_item(checklist_item)
    content&.sub!(
      /[-|*] \[([ xX*])\] #{Regexp.escape(checklist_item.text)}/,
      "- [#{checklist_item.checked ? 'x' : ' '}] #{checklist_item.text}"
    )

    save!
  end
end
