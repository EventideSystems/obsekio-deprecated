# frozen_string_literal: true

# Handles the updating of checklist items
class ChecklistItemsController < ApplicationController
  def update
    checklist_instance = ChecklistInstance.find(params[:checklist_instance_id])
    index = params[:id].to_i
    item_state = params[:checklist_item].permit(:checked)

    ChecklistItemEvent.create(checklist_instance:, index:, item_state:)

    head :no_content
  end
end
