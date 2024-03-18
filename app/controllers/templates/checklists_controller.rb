# frozen_string_literal: true

module Templates
  # Controller for checklist templates
  class ChecklistsController < ApplicationController
    group :templates

    def index
      @checklists = Templates::Checklist.all
    end

    def show
      @checklist = Templates::Checklist.find(params[:id])
    end

    def edit
      @checklist = Templates::Checklist.find(params[:id])
    end

    def update
      @checklist = Templates::Checklist.find(params[:id])
      @checklist.update(checklist_params)

      console
      redirect_to templates_checklist_path(@checklist)
    end

    def checklist_params
      params.require(:templates_checklist).permit(:title, :content, :status)
    end
  end
end
