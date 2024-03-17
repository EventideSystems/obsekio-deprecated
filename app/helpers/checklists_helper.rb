# frozen_string_literal: true

# Helper methods for checklists
module ChecklistsHelper
  STATUS_DOT_CLASSES = {
    Templates::Checklist => {
      draft: 'text-yellow-500 bg-yellow-100/10',
      published: 'text-green-400 bg-green-400/10',
      archived: 'text-red-400 bg-red-400/10'
    },
    Library::Checklist => {}
  }.freeze

  def render_checklist_status_dot(checklist)
    render 'checklists/shared/status_dot', classes: STATUS_DOT_CLASSES.dig(checklist.class, checklist.status.to_sym)
  end

  def render_checklist(checklist)
    Pipeline.new.call(checklist.content)[:output].html_safe # rubocop:disable Rails/OutputSafety
  end
end
