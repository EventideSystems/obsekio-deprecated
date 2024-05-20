# frozen_string_literal: true

module Library
  # Controller for library checklists
  class ChecklistsController < ApplicationController
    group :library

    around_action :use_logidze_responsible, only: %i[create update]
    before_action :load_checklist, only: %i[show edit update copy_to_workspace publish]

    def index
      @checklists = policy_scope(Library::Checklist).all
      authorize Library::Checklist
    end

    def show; end

    def new
      @checklist = Library::Checklist.new
      authorize @checklist
    end

    def create
      @checklist = Library::Checklist.new(checklist_params)
      authorize @checklist

      if @checklist.save
        redirect_to library_checklist_path(@checklist)
      else
        render :new
      end
    end

    def edit; end

    def update
      @checklist.update(checklist_params)

      redirect_to library_checklist_path(@checklist)
    end

    # NOTE: This is a custom action that is not part of the standard RESTful actions
    def copy_to_workspace
      workspace_checklist = build_workspace_checklist(@checklist)

      if workspace_checklist.save
        redirect_to workspace_checklist_path(workspace_checklist),
                    notice: 'Checklist successfully copied to your workspace'
      else
        render :show, notice: 'Failed to copy checklist to workspace'
      end
    end

    # NOTE: This is a custom action that is not part of the standard RESTful actions
    def publish
      authorize @checklist

      if @checklist.update(status: :published)
        redirect_to library_checklist_path(@checklist), notice: 'Checklist published'
      else
        redirect_to library_checklist_path(@checklist), notice: 'Checklist failed to publish'
      end
    end

    def checklist_params
      params
        .require(:library_checklist)
        .permit(policy(Library::Checklist).permitted_attributes)
    end

    private

    # TODO: Refactor this into an event object? In any case, change this use the new Checklist model
    # when it becomes available
    def build_workspace_checklist(checklist)
      checklist.checklist_type.constantize.new(
        title: checklist.title,
        content: checklist.content,
        assignee: current_user,
        created_by: checklist.created_by
      )
    end

    def load_checklist
      @checklist = Library::Checklist.find(params[:id])
      authorize @checklist
    end
  end
end
