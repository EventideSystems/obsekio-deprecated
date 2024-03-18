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
  end
end
