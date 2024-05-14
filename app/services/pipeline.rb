# frozen_string_literal: true

require 'html_pipeline'
require 'html_pipeline/convert_filter/markdown_filter'

# Converts markdown to HTML
class Pipeline
  # Private class to convert Obsekio-flavored radio button markdown to HTML
  class CheckedStateFilter < HTMLPipeline::NodeFilter
    SELECTOR = Selma::Selector.new(match_element: '[type="checkbox"]')

    def initialize(checklist_instance: nil)
      if checklist_instance.present? && checklist_instance.is_a?(ChecklistInstance)
        @checklist_instance = checklist_instance
        @checklist_item_states = checklist_instance&.item_states&.dup || []
      end

      super()
    end

    def selector
      SELECTOR
    end

    def handle_element(element)
      state = @checklist_item_states&.shift
      element['checked'] = 'checked' if state.present? && state['checked']
    end
  end

  def call(markdown, checklist_instance = nil)
    return { output: '' } if markdown.blank?

    pipeline = HTMLPipeline.new(
      convert_filter: HTMLPipeline::ConvertFilter::MarkdownFilter.new,
      sanitization_config: sanitize_config,
      node_filters: [CheckedStateFilter.new(checklist_instance:)]
    )

    pipeline.call(markdown)
  end

  # def call(markdown)
  #   pipeline = HTMLPipeline.new(
  #     convert_filter: HTMLPipeline::ConvertFilter::MarkdownFilter.new,
  #     # NOTE: next line is not needed as sanitization occurs by default;
  #     # see below for more info
  #     sanitization_config: sanitize_config
  #     # node_filters: [HTMLPipeline::NodeFilter::MentionFilter.new]
  #   )

  #   pipeline.call(markdown) # recommended: can call pipeline over and over
  # end

  private

  def sanitize_config
    HTMLPipeline::SanitizationFilter::DEFAULT_CONFIG.dup.tap do |config|
      config[:elements] = config[:elements].dup << 'input'
      config[:attributes] = config[:attributes].merge('input' => ['type'])
    end
  end
end
