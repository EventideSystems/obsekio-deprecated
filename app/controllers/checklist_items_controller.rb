# frozen_string_literal: true

# Handles the updating of checklist items
class ChecklistItemsController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  before_action :load_checklist_instance

  attr_reader :checklist_instance

  def update
    index = params[:id].to_i
    item_state = build_item_state(index)

    ChecklistItemEvent.create(checklist_instance:, index:, item_state:, user: current_user, true_user:)

    head :no_content
  end

  private

  def build_item_state(index)
    { text: build_text(index), state: build_state }.tap do |item_state|
      item_state[:comment] = build_comment if params.dig(:checklist_item, :comment).present?
    end
  end

  def build_text(index)
    sanitize(checklist_instance.checklist.items[index].text.chomp)
  end

  def build_comment
    sanitize(params.fetch(:checklist_item).fetch(:comment))
  end

  def build_state
    case checklist_instance.checklist.data_entry_input_type
    when 'checkbox'
      params.fetch(:checklist_item).fetch(:value) == 'on' ? 'checked' : 'unchecked'
    when 'radio'
      sanitize(params[:checklist_item].fetch(:value))
    end
  end

  def load_checklist_instance
    @checklist_instance = ChecklistInstance.find(params[:checklist_instance_id])
    authorize @checklist_instance, :update_items?
  end
end
