# frozen_string_literal: true

# Parses a markdown string into a list of checklist items
class ChecklistItemsParser
  attr_reader :markdown, :checklist_instance

  CHECK_INDICATORS = %w[x X *].freeze

  def initialize(markdown)
    @markdown = markdown
  end

  def parse
    markdown.scan(/[-|*]\s\[(\s|\*|x|X)\]\s(.*)$/).map.with_index do |(raw_checked, text), index|
      checked = raw_checked.strip.in?(CHECK_INDICATORS)
      ChecklistItem.new(checked:, index:, text:)
    end
  end
end
