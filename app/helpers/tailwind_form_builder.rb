# frozen_string_literal: true

# Custom FormBuilder adding Tailwind classes to form fields.
class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, opts = {}, &block)
    default_opts = { class: 'block text-sm font-medium leading-6 text-white' }
    merged_opts = default_opts.merge(opts)
    super(method, text, merged_opts, &block)
  end

  def submit(value = nil, options = {})
    default_opts = { class: 'rounded-md bg-indigo-500 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500' }
    merged_opts = default_opts.merge(options)
    super(value, merged_opts)
  end

  def text_field(method, opts = {})
    default_opts = { class: "block w-full rounded-md border-0 bg-white/5 py-1.5 text-white shadow-sm ring-1 ring-inset ring-white/10 focus:ring-2 focus:ring-inset focus:ring-indigo-500 sm:text-sm sm:leading-6 #{if @object.errors.any?
                                                                                                                                                                                                                     'border-2 border-red-500'
                                                                                                                                                                                                                   end}" }
    merged_opts = default_opts.merge(opts)
    super(method, merged_opts)
  end
end
