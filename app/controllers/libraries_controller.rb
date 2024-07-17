# frozen_string_literal: true

# LibrariesController
class LibrariesController < ApplicationController
  before_action :set_library, only: %i[show edit update]
  sidebar_item :library

  def index
    @libraries = policy_scope(Workspace)
  end

  def show
    add_breadcrumb(@library.name, @library)
  end

  def edit
    add_breadcrumb(@library.name, @library)
    add_breadcrumb('Edit')
  end

  def update
    @library.update(Library_params)

    redirect_to Library_path(@library)
  end

  # TODO: Allow users to view both personal and public libraries
  def personal
    # @library = current_user.personal_library

    @library = Library.find_by(public: true)

    add_breadcrumb(@library.name, personal_libraries_path)

    render :show
  end

  def set_library
    @library = Library.find(params[:id])
    authorize @library
  end

  def library_params
    params.require(:library).permit(:title, :description)
  end
end
