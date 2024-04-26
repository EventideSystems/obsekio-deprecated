# frozen_string_literal: true

# Handles the updating of checklist items
class ChecklistItemsController < ApplicationController
  def update
    checklist_instance = ChecklistInstance.find(params[:checklist_instance_id])
    checklist_item = checklist_instance.checklist_items[params[:id].to_i]
    checklist_item.checked = params[:checklist_item][:checked]
    checklist_instance.update_checklist_item(checklist_item)
    checklist_instance.save

    head :no_content
  end
end
