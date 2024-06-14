# frozen_string_literal: true

# Mangagement of checklist instances, wtih the context of a container (library or workspace)
class ChecklistInstancesController < ApplicationController
  before_action :set_checklist
  before_action :set_checklist_instance, only: %i[show edit update destroy]
  after_action :set_group

  def index
    @checklist_instances = policy_scope(ChecklistInstance)
  end

  def show
    add_base_breadcrumbs
    add_breadcrumb(@checklist_instance.title)
  end

  def new
    @checklist_instance = @checklist.checklist_instances.new

    add_base_breadcrumbs
    add_breadcrumb("New #{@checklist_instance.instance_model_name.titleize.singularize}")
  end

  def edit; end

  def create
    @checklist_instance = build_checklist_instance
    authorize @checklist_instance

    if @checklist_instance.save
      handle_successful_save
    else
      handle_unsuccessful_save
    end
  end

  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @checklist_instance.update(checklist_instance_params)
        format.html do
          redirect_to checklist_instance_url(@checklist, @checklist_instance),
                      notice: "#{@checklist_instance.instance_model_name.titleize} was successfully updated."
        end
        format.json { render :show, status: :ok, location: @checklist_instance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @checklist_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @checklist_instance.destroy!

    respond_to do |format|
      format.html do
        redirect_to checklist_instances_url,
                    notice: "#{@checklist_instance.instance_model_name.titleize} was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  def add_base_breadcrumbs
    add_breadcrumb(@checklist.container.name, @checklist.container) if @checklist.container
    add_breadcrumb(@checklist.title, @checklist.becomes(Checklist))
    add_breadcrumb(@checklist.instance_model_name.titleize.pluralize, @checklist.becomes(Checklist))
  end

  def build_checklist_instance
    @checklist.checklist_instances.new(checklist_instance_params).tap(&:prepare_items)
  end

  def handle_successful_save
    respond_to do |format|
      format.html do
        redirect_to checklist_instance_url(@checklist, @checklist_instance),
                    notice: "#{@checklist_instance.instance_model_name.titleize} was successfully created."
      end
      format.json { render :show, status: :created, location: @checklist_instance }
    end
  end

  def handle_unsuccessful_save
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @checklist_instance.errors, status: :unprocessable_entity }
    end
  end

  def set_checklist
    @checklist = Checklist.find(params[:checklist_id])
    authorize @checklist, :show?
  end

  def set_checklist_instance
    @checklist_instance = ChecklistInstance.find(params[:id])
    authorize @checklist_instance
  end

  # Only allow a list of trusted parameters through.
  def checklist_instance_params
    params.require(:checklist_instance).permit(:title)
  end

  def set_group
    case @checklist_instance&.checklist&.container
    when Library
      group :library
    when Workspace
      group :workspace
    end
  end
end
