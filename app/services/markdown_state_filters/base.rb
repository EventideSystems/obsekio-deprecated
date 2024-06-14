# frozen_string_literal: true

module MarkdownStateFilters
  # Base template class for markdown state filters. Subclasses must implement
  # the `_handle_element` method.
  class Base < HTMLPipeline::NodeFilter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::SanitizeHelper

    attr_reader :checklist_instance, :checklist_item_states, :checked_color, :data_entry_input_type

    def initialize(checklist_instance: nil)
      if checklist_instance.present? && checklist_instance.is_a?(ChecklistInstance)
        @checklist_instance = checklist_instance
        @checklist_item_states = checklist_instance.item_states.dup || []
        @data_entry_input_type = checklist_instance.data_entry_input_type.to_sym || :checkbox
      end

      super()
    end

    SELECTOR = Selma::Selector.new(match_element: '[type="checkbox"]').freeze

    COLORS = {
      red: ['text-red-700', 'focus:ring-red-700'],
      orange: ['text-orange-700', 'focus:ring-orange-700'],
      amber: ['text-amber-700', 'focus:ring-amber-700'],
      yellow: ['text-yellow-700', 'focus:ring-yellow-700'],
      lime: ['text-lime-700', 'focus:ring-lime-700'],
      green: ['text-green-700', 'focus:ring-green-700'],
      emerald: ['text-emerald-700', 'focus:ring-emerald-700'],
      teal: ['text-teal-700', 'focus:ring-teal-700'],
      cyan: ['text-cyan-700', 'focus:ring-cyan-700'],
      sky: ['text-sky-700', 'focus:ring-sky-700'],
      blue: ['text-blue-700', 'focus:ring-blue-700'],
      indigo: ['text-indigo-700', 'focus:ring-indigo-700'],
      violet: ['text-violet-700', 'focus:ring-violet-700'],
      purple: ['text-purple-700', 'focus:ring-purple-700'],
      fuchsia: ['text-fuchsia-700', 'focus:ring-fuchsia-700'],
      pink: ['text-pink-700', 'focus:ring-pink-700'],
      rose: ['text-rose-700', 'focus:ring-rose-700']
    }.freeze

    def selector = SELECTOR

    def handle_element(element)
      element.remove_attribute('disabled')
      state = @checklist_item_states&.shift

      return if state.blank?

      item_index = checklist_instance.item_states.index(state)

      _handle_element(element, state, item_index)
    end

    def _handle_element(element, state, item_index)
      raise NotImplementedError, 'Subclasses must implement this method'
    end
  end
end
