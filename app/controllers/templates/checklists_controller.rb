# frozen_string_literal: true

module Templates
  # Controller for checklist templates
  class ChecklistsController < ApplicationController
    group :templates

    before_action :load_checklist, only: %i[show edit update copy_to_library publish]

    def index
      @checklists = policy_scope(Templates::Checklist).all
      authorize Templates::Checklist
    end

    def show; end

    def new
      @checklist = Templates::Checklist.new
      authorize @checklist
    end

    def create
      @checklist = Templates::Checklist.new(checklist_params)
      authorize @checklist

      if @checklist.save
        redirect_to templates_checklist_path(@checklist)
      else
        render :new
      end
    end

    def edit; end

    def update
      @checklist.update(checklist_params)

      redirect_to templates_checklist_path(@checklist)
    end

    # NOTE: This is a custom action that is not part of the standard RESTful actions
    def copy_to_library
      library_checklist = build_library_checklist(@checklist)

      if library_checklist.save
        redirect_to templates_checklist_path(@checklist),
                    notice: 'Checklist successfully copied to your library'
      else
        render :show, notice: 'Failed to copy checklist to library'
      end
    end

    # NOTE: This is a custom action that is not part of the standard RESTful actions
    def publish
      authorize @checklist

      if @checklist.update(status: :published)
        redirect_to templates_checklist_path(@checklist), notice: 'Checklist published'
      else
        redirect_to templates_checklist_path(@checklist), notice: 'Checklist failed to publish'
      end
    end

    def checklist_params
      params.require(:templates_checklist).permit(:title, :content, :status)
    end

    private

    # TODO: Refactor this into an event object? In any case, change this use the new Library::Checklist model
    # when it becomes available
    def build_library_checklist(checklist)
      Library::Checklist.new(
        title: checklist.title,
        content: checklist.content.body,
        status: :draft
        # assignee: current_user
      )
    end

    def load_checklist
      @checklist = Templates::Checklist.find(params[:id])
      authorize @checklist
    end
  end
end
