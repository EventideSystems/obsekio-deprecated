# frozen_string_literal: true

# NOTE: This controller is not currently used in the application, and we're not sure exactly how it should be used.
# We're going to refactor it to be more useful and to match the way the various instance models handle
# CheckListInstance records.
class ChecklistInstancesController < ApplicationController
  before_action :set_checklist_instance, only: %i[show edit update destroy]

  # GET /checklist_instances or /checklist_instances.json
  def index
    @checklist_instances = ChecklistInstance.all
  end

  # GET /checklist_instances/1 or /checklist_instances/1.json
  def show; end

  # GET /checklist_instances/new
  def new
    @checklist_instance = ChecklistInstance.new
  end

  # GET /checklist_instances/1/edit
  def edit; end

  # POST /checklist_instances or /checklist_instances.json
  def create # rubocop:disable Metrics/MethodLength
    @checklist_instance = ChecklistInstance.new(checklist_instance_params)

    respond_to do |format|
      if @checklist_instance.save
        format.html do
          redirect_to checklist_instance_url(@checklist_instance),
                      notice: 'Checklist instance was successfully created.'
        end
        format.json { render :show, status: :created, location: @checklist_instance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @checklist_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checklist_instances/1 or /checklist_instances/1.json
  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @checklist_instance.update(checklist_instance_params)
        format.html do
          redirect_to checklist_instance_url(@checklist_instance),
                      notice: 'Checklist instance was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @checklist_instance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @checklist_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklist_instances/1 or /checklist_instances/1.json
  def destroy
    @checklist_instance.destroy!

    respond_to do |format|
      format.html { redirect_to checklist_instances_url, notice: 'Checklist instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_checklist_instance
    @checklist_instance = ChecklistInstance.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def checklist_instance_params
    params.fetch(:checklist_instance, {})
  end
end
