# frozen_string_literal: true

require 'html_pipeline'
require 'html_pipeline/convert_filter/markdown_filter'

# Converts markdown to HTML
class MarkdownRenderer
  # Private class to convert markdown to HTML
  class CheckedStateFilter < HTMLPipeline::NodeFilter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::SanitizeHelper

    SELECTOR = Selma::Selector.new(match_element: '[type="checkbox"]')

    attr_reader :checklist_instance, :checklist_item_states, :checked_color, :data_entry_input_type, :state_filter

    def initialize(checklist_instance: nil)
      if checklist_instance.present? && checklist_instance.is_a?(ChecklistInstance)
        @checklist_instance = checklist_instance
        @checklist_item_states = checklist_instance.item_states.dup || []
        @data_entry_input_type = checklist_instance.data_entry_input_type.to_sym || :checkbox
        @state_filter = build_state_filter(checklist_instance)
      end

      super()
    end

    def selector = SELECTOR

    def handle_element(element)
      element.remove_attribute('disabled')
      state = @checklist_item_states&.shift

      return if state.blank?

      item_index = checklist_instance.item_states.index(state)

      state_filter._handle_element(element, state, item_index)
    end

    private

    def build_state_filter(checklist_instance)
      "MarkdownStateFilters::#{data_entry_input_type.to_s.camelize}".constantize.new(checklist_instance:)
    end
  end

  def call(markdown, checklist_instance = nil)
    return '' if markdown.blank?

    pipeline = HTMLPipeline.new(
      convert_filter: HTMLPipeline::ConvertFilter::MarkdownFilter.new,
      sanitization_config: sanitize_config,
      node_filters: [CheckedStateFilter.new(checklist_instance:)]
    )

    pipeline.call(markdown)[:output]
  end

  private

  def sanitize_config
    HTMLPipeline::SanitizationFilter::DEFAULT_CONFIG.dup.tap do |config|
      config[:elements] = config[:elements].dup << 'input'
      config[:attributes] = config[:attributes].merge('input' => %w[type class name id value title data-item-index])
    end
  end

  def node_filters
    node_filter_class = "MarkdownStateFilters::#{checklist_instance.data_entry_input_type.to_s.camelize}".constantize
    [node_filter_class.new(checklist_instance:)]
  end
end
