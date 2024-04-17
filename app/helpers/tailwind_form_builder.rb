# frozen_string_literal: true

# Custom FormBuilder adding Tailwind classes to form fields.
class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  # rubocop:disable Layout/LineLength
  SUBMIT_BUTTON_CLASS = 'rounded-md bg-indigo-500 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500'
  TEST_FIELD_CLASS = 'block w-full rounded-md border-0 bg-white/5 py-1.5 text-white shadow-sm ring-1 ring-inset ring-white/10 focus:ring-2 focus:ring-inset focus:ring-indigo-500 sm:text-sm sm:leading-6'
  # rubocop:enable Layout/LineLength
  ERROR_BORDER_CLASS = 'border-2 border-red-500'
  LABEL_CLASS = 'block text-sm font-medium leading-6 text-white'

  def label(method, text = nil, opts = {}, &block)
    default_opts = { class: LABEL_CLASS }
    merged_opts = default_opts.merge(opts)
    super(method, text, merged_opts, &block)
  end

  def submit(value = nil, options = {})
    default_opts = { class: SUBMIT_BUTTON_CLASS }
    merged_opts = default_opts.merge(options)
    super(value, merged_opts)
  end

  def text_field(method, opts = {})
    default_opts = { class: build_default_field_class(TEST_FIELD_CLASS, ERROR_BORDER_CLASS, method) }
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
