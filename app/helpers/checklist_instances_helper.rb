module ChecklistInstancesHelper
  # SMELL: This method is identical to the one in ChecklistsHelper
  def render_checklist_instance(checklist_instance)
    Pipeline.new.call(checklist_instance.content.to_markdown)[:output].html_safe # rubocop:disable Rails/OutputSafety
  end
end
