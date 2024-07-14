# frozen_string_literal: true

# Default "workspace" resource. NB this is a singular resource, as the user can only have one workspace.
# The workspace is a container for all other resources in the application and presents an entry point to
# checklists and other resources
class WorkspaceController < ApplicationController
  def show
    @checklists = policy_scope(Checklist)
  end
end
