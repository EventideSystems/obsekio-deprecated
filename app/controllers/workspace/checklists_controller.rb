# frozen_string_literal: true

module Workspace
  # Controller for Workspace checklists
  class ChecklistsController < ApplicationController
    group :root

    def index
      @checklists = Workspace::Checklist.all
    end

    def show
      @checklist = Workspace::Checklist.find(params[:id])
    end

    def edit
      @checklist = Library::Checklist.find(params[:id])
    end

    def update
      @checklist = Workspace::Checklist.find(params[:id])
      @checklist.update(checklist_params)

      redirect_to workspace_checklist_path(@checklist)
    end

    def checklist_params
      params.require(:Workspace_checklist).permit(:title, :content, :status)
    end
  end
end
