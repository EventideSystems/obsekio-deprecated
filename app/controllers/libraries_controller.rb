# frozen_string_literal: true

# LibrariesController
class LibrariesController < ApplicationController
  group :library

  def index
    @libraries = Library.all
  end

  def show
    @library = Library.find(params[:id])
  end

  def edit
    @library = Library.find(params[:id])
  end

  def update
    @library = Library.find(params[:id])
    @library.update(Library_params)

    redirect_to Library_path(@library)
  end

  def personal
    # @library = current_user.personal_library

    @library = Library.system_library

    add_breadcrumb(@library.name, personal_libraries_path)

    render :show
  end

  def library_params
    params.require(:library).permit(:title, :description)
  end
end
