# frozen_string_literal: true

# Represents an instance, or run through, of a checklist
class ChecklistInstance < ApplicationRecord
  include StringEnum
  has_markdown :content

  belongs_to :checklist
  belongs_to :assignee, polymorphic: true, optional: true

  def checklist_items
    @checklist_items ||= ChecklistItemsParser.new(content&.to_markdown).parse
  end

  def update_checklist_item(checklist_item)
    content.body = \
      content&.to_markdown&.sub!(
        /- \[([ xX*])\] #{Regexp.escape(checklist_item.text)}/,
        "- [#{checklist_item.checked ? 'x' : ' '}] #{checklist_item.text}"
      )
  end
end
