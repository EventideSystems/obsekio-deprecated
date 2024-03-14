# frozen_string_literal: true

module Library
  class ChecklistsController < ApplicationController
    def index
      @checklists = Checklist.all
    end

    def show
      @checklist = Checklist.find(params[:id])
    end

    def new
      @checklist = Checklist.new
    end

    def create
      @checklist = Checklist.new(checklist_params)
      if @checklist.save
        redirect_to library_checklists_path
      else
        render :new
      end
    end

    def edit
      @checklist = Checklist.find(params[:id])
    end

    def update
      @checklist = Checklist.find(params[:id])
      if @checklist.update(checklist_params)
        redirect_to library_checklists_path
      else
        render :edit
      end
    end

    def destroy
      @checklist = Checklist.find(params[:id])
      @checklist.destroy
      redirect_to library_checklists_path
    end

    private

    def checklist_params
      params.require(:checklist).permit(:name, :description)
    end
  end
end
