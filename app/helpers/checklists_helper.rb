# frozen_string_literal: true

# Helper methods for checklists
module ChecklistsHelper
  def render_checklist(checklist)
    MarkdownRenderer.new.call(checklist.content, checklist).html_safe # rubocop:disable Rails/OutputSafety
  end

  # rubocop:disable Layout/LineLength
  CHECKLIST_ACTION_CLASSES = 'relative -mr-px inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-bl-lg border border-transparent py-4 text-sm font-semibold text-gray-900'
  # rubocop:enable Layout/LineLength

  def link_to_checklist_action(checklist)
    case checklist.status.to_sym
    when :draft then link_to('Edit', edit_checklist_path(checklist), class: CHECKLIST_ACTION_CLASSES)
    when :ready then link_to('Start', checklist_path(checklist), class: CHECKLIST_ACTION_CLASSES)
    when :in_progress then link_to('Continue', checklist_path(checklist), class: CHECKLIST_ACTION_CLASSES)
    else
      link_to 'View', edit_checklist_path(checklist)
    end
  end

  def options_for_checklist_type_select
    [
      Checklists::Single,
      Checklists::Concurrent
    ].map { |type| [type.model_name.human, type.to_s] }
  end

  def options_for_data_entry_input_type_select
    [
      %w[Checkbox checkbox],
      %w[Radio radio],
      %w[Dialog dialog],
      %w[Dropdown dropdown]
    ]
  end

  def options_for_data_entry_comments_select
    [
      %w[Disallow disallowed],
      %w[Allowed allowed],
      %w[Prompt prompt],
      %w[Required required]
    ]
  end

  # rubocop:disable Layout/HashAlignment
  BASE_CONCURRENT_CHECKLIST_LIST_ITEM_COLOR_CLASSES = {
    red:     'bg-red-600',
    orange:  'bg-orange-600',
    amber:   'bg-amber-600',
    yellow:  'bg-yellow-600',
    lime:    'bg-lime-600',
    green:   'bg-green-600',
    emerald: 'bg-emerald-600',
    teal:    'bg-teal-600',
    cyan:    'bg-cyan-600',
    sky:     'bg-sky-600',
    blue:    'bg-blue-600',
    indigo:  'bg-indigo-600',
    violet:  'bg-violet-600',
    purple:  'bg-purple-600',
    fuchsia: 'bg-fuchsia-600',
    pink:    'bg-pink-600',
    rose:    'bg-rose-600'
  }.freeze
  # rubocop:enable Layout/HashAlignment

  def concurrent_checklist_list_item(checklist_instance, item)
    base_color = checklist_instance&.checklist&.base_color_for_state(item.state) || :gray
    background_color = BASE_CONCURRENT_CHECKLIST_LIST_ITEM_COLOR_CLASSES[base_color.to_sym] || 'bg-gray-400'

    content_tag(
      :div,
      '',
      class: "p-1 h-1 border rounded-sm #{background_color}",
      title: item.text,
      data: { item_state: item.state }
    )
  end
end
