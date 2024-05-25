# frozen_string_literal: true

# Helper methods for checklists
module ChecklistsHelper
  def render_checklist(checklist)
    Pipeline.new.call(checklist.content, checklist)[:output].html_safe # rubocop:disable Rails/OutputSafety
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
end
