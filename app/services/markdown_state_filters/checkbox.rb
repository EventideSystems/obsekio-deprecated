# frozen_string_literal: true

module MarkdownStateFilters
  # Private class to convert markdown to HTML
  class Checkbox < Base
    def _handle_element(element, state, item_index)
      element['class'] = checkbox_classes
      element['data-item-index'] = item_index.to_s
      element['checked'] = 'checked' if state&.dig('state') == 'checked'
    end

    private

    CHECKBOX_CLASSES = 'mr-2 h-4 w-4 rounded border-gray-300'

    def checkbox_classes
      checked_color = checklist_instance&.data_entry_checkbox_checked_color&.to_sym || :green
      color_classes = COLORS[checked_color].join(' ')

      "#{CHECKBOX_CLASSES} #{color_classes}"
    end
  end
end
