# frozen_string_literal: true

# Access to the contexts within a workspace.
class ContextsController < ApplicationController
  before_action :set_workspace
  before_action :set_context, only: %i[show edit update destroy]

  def index
    @contexts = @workspace.contexts

    add_breadcrumb(@workspace.name, @workspace)
    add_breadcrumb('Admin', settings_workspace_path(@workspace))
    add_breadcrumb('Contexts')
  end

  def show; end

  def new
    @context = Context.new
  end

  def edit; end

  def create
    @context = create_context

    respond_to do |format|
      if @context.save
        format.html { redirect_to context_url(@context), notice: 'Context was successfully created.' }
        format.json { render :show, status: :created, location: @context }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @context.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @context.update(context_params)
        format.html { redirect_to context_url(@context), notice: 'Context was successfully updated.' }
        format.json { render :show, status: :ok, location: @context }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @context.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @context.destroy!

    respond_to do |format|
      format.html { redirect_to contexts_url, notice: 'Context was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def context_params
    params.fetch(:context, {})
  end

  def create_context
    @context = Context.new(context_params)
    @context.workspace = @workspace
    authorize @context
  end

  def set_context
    @context = Context.find(params[:id])
    authorize @context
  end

  def set_workspace
    @workspace = Workspace.find(params[:workspace_id])
    authorize @workspace, :show? # TODO: Review this. We might want a more specific policy check here.
  end
end
