# frozen_string_literal: true

require 'html_pipeline'
require 'html_pipeline/convert_filter/markdown_filter'

# Converts markdown to HTML
class Pipeline
  # Private class to convert Obsekio-flavored radio button markdown to HTML
  class RadioButtonFilter < HTMLPipeline::NodeFilter
    def call
      doc.search('.//text()').each do |node|
        content = node.to_html
        next unless content.include?('- ( )')

        html = convert_to_radio_button(content)
        node.replace(html)
      end
      doc
    end

    private

    def convert_to_radio_button(content)
      content.gsub!(/-\s\(\s\)\s(.*)/, '<input type="radio"> \1')
    end
  end

  def call(markdown)
    pipeline = HTMLPipeline.new(
      convert_filter: HTMLPipeline::ConvertFilter::MarkdownFilter.new,
      sanitization_config: sanitize_config
      # node_filters: [RadioButtonFilter.new]
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
