# frozen_string_literal: true

# Handles the updating of checklist items
class ChecklistItemsController < ApplicationController
  def update
    checklist_instance = ChecklistInstance.find(params[:checklist_instance_id])
    authorize checklist_instance, :update?

    index = params[:id].to_i
    item_state = params[:checklist_item].permit(:checked)

    # TODO: Add current_user to the event
    ChecklistItemEvent.create(checklist_instance:, index:, item_state:)

    head :no_content
  end
end
