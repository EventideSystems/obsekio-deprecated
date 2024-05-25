# frozen_string_literal: true

# Custom FormBuilder adding Tailwind classes to form fields.
class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  # rubocop:disable Layout/LineLength
  SUBMIT_BUTTON_CLASS = 'rounded-md bg-yellow-500 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-yellow-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-yellow-500'
  TEXT_FIELD_CLASS = 'block w-full rounded-md border-0 bg-white/5 py-1.5 text-gray-900 dark:text-white shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-white/10 focus:ring-2 focus:ring-inset focus:ring-yellow-500 sm:text-sm sm:leading-6'
  SELECT_FIELD_CLASS = 'mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-yellow-500 sm:text-sm sm:leading-6'
  # rubocop:enable Layout/LineLength
  ERROR_BORDER_CLASS = 'border-2 border-red-500'
  LABEL_CLASS = 'block text-sm font-medium leading-6 text-gray-900 dark:text-white'

  def label(method, text = nil, opts = {}, &block)
    default_opts = { class: LABEL_CLASS }
    merged_opts = default_opts.merge(opts)
    super(method, text, merged_opts, &block)
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    default_opts = { class: build_default_field_class(SELECT_FIELD_CLASS, ERROR_BORDER_CLASS, method) }
    merged_opts = default_opts.merge(html_options)

    @template.content_tag(:div) do
      @template.concat(super(method, choices, options, merged_opts, &block))
      append_error_message(@object, method)
    end
  end

  def submit(value = nil, options = {})
    default_opts = { class: SUBMIT_BUTTON_CLASS }
    merged_opts = default_opts.merge(options)
    super(value, merged_opts)
  end

  def text_field(method, opts = {})
    default_opts = { class: build_default_field_class(TEXT_FIELD_CLASS, ERROR_BORDER_CLASS, method) }
    merged_opts = default_opts.merge(opts)

    @template.content_tag(:div) do
      @template.concat(super(method, merged_opts))
      append_error_message(@object, method)
    end
  end

  private

  def append_error_message(object, method)
    return unless object.errors[method].any?

    object.errors[method].each do |error_message|
      @template.concat(
        @template.content_tag(:div, class: 'h-2 mt-2 mb-4 text-xs text-red-500 dark:text-red-500') do
          error_message.html_safe # rubocop:disable Rails/OutputSafety
        end
      )
    end
  end

  def build_default_field_class(base_class, error_class, method)
    base_class + (@object.errors[method].any? ? " #{error_class}" : '')
  end
end
