# frozen_string_literal: true

# Helper methods for ChecklistInstances
module ChecklistInstancesHelper
  # # SMELL: This method is identical to the one in ChecklistsHelper
  # def render_checklist_instance(checklist_instance)
  #   Pipeline.new.call(checklist_instance.content.to_markdown, checklist_instance)[:output].html_safe
  # end
end
