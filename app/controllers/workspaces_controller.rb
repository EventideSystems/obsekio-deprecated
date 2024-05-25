# frozen_string_literal: true

# WorkspacesController
class WorkspacesController < ApplicationController
  group :workspace

  def index
    @workspaces = Workspace.all
  end

  def show
    @workspace = Workspace.find(params[:id])
    add_breadcrumb(@workspace.name, @workspace)
  end

  def edit
    @workspace = Workspace.find(params[:id])
  end

  def update
    @workspace = Workspace.find(params[:id])
    @workspace.update(workspace_params)

    redirect_to workspace_path(@workspace)
  end

  def personal
    @workspace = current_user.personal_workspace
    add_breadcrumb(@workspace.name, personal_workspaces_path)

    # add_breadcrumb(@workspace.name)

    render :show
  end

  def workspace_params
    params.require(:workspace).permit(:title, :description)
  end
end
