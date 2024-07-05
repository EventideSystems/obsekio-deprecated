# frozen_string_literal: true

# WorkspacesController
class WorkspacesController < ApplicationController
  before_action :set_workspace, only: %i[show edit update settings]

  group :workspace

  def index
    @workspaces = policy_scope(Workspace)
  end

  def show
    add_breadcrumb(@workspace.name, @workspace)
  end

  def edit
    add_breadcrumb(@workspace.name, @workspace)
    add_breadcrumb('Edit')
  end

  def update
    @workspace.update(workspace_params)

    redirect_to workspace_path(@workspace)
  end

  def personal
    @workspace = current_user.personal_workspace
    authorize @workspace

    add_breadcrumb(@workspace.name, personal_workspaces_path)

    render :show
  end

  def settings
    add_breadcrumb(@workspace.name, @workspace)
    add_breadcrumb('Admin')
  end

  private

  def set_workspace
    @workspace = Workspace.find(params[:id])
    authorize @workspace
  end

  def workspace_params
    params.require(:workspace).permit(:title, :description)
  end
end
