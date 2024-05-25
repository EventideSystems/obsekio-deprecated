# frozen_string_literal: true

# ChecklistsController
class ChecklistsController < ApplicationController
  around_action :use_logidze_responsible, only: %i[create update]
  after_action :set_group

  def index
    @checklists = Checklist.all # TODO: Restrict to what the user has access to.
  end

  def show
    @checklist = Checklist.find(params[:id])

    add_breadcrumb(@checklist.container.name, @checklist.container)

    if @checklist.is_a?(Checklists::Concurrent)
      add_breadcrumb(@checklist.title, @checklist.becomes(Checklist))
      add_breadcrumb('Instances')
    else
      add_breadcrumb(@checklist.title)
    end
  end

  def new
    @container = find_container(*params.values_at(:container_type, :container_id))
    @checklist = Checklist.new(container: @container)

    add_breadcrumb(@checklist.container.name, @checklist.container) if @checklist.container
    add_breadcrumb('New Checklist')
  end

  def create
    @container = find_container(*params[:checklist].values_at(:container_type, :container_id))
    @checklist = build_new_checklist(@container)

    if @checklist.save
      redirect_to edit_checklist_path(id: @checklist.id)
    else
      add_breadcrumb(@checklist.container.name, @checklist.container) if @checklist.container
      add_breadcrumb('New Checklist')

      render :new
    end
  end

  def edit
    @checklist = Checklist.find(params[:id])

    add_breadcrumb(@checklist.container.name, @checklist.container)
    add_breadcrumb(@checklist.title)
  end

  def update
    @checklist = Checklist.find(params[:id])
    # TODO: add support for other types of checklists, not just single checklists, either here or in the form
    case @checklist
    when Checklists::Single
      @checklist.update(checklists_single_params)
    when Checklists::Concurrent
      @checklist.update(checklists_concurrent_params)
    end

    redirect_to checklist_path(@checklist)
  end

  def details
    @checklist = Checklist.find(params[:id])
    render :show # render the show template for now
  end

  private

  def build_new_checklist(container)
    checklist_type = sanitize_checklist_type(params[:checklist][:type])
    checklist_klass = checklist_type.constantize

    checklist_klass.new(container:).tap do |checklist|
      checklist.update(create_checklist_params)
    end
  end

  def checklists_single_params
    params.require(:checklists_single).permit(:title, :content, :status)
  end

  def checklists_concurrent_params
    params.require(:checklists_concurrent).permit(:title, :content, :status)
  end

  def create_checklist_params
    params.require(:checklist).permit(:title, :content, :status)
  end

  def find_container(type, id)
    case type.downcase.to_sym
    when :library
      Library.find(id)
    when :workspace
      Workspace.find(id)
    else
      raise "Unknown container type: #{type}"
    end
  end

  ALLOWED_CHECKLIST_TYPES = %w[Checklists::Single Checklists::Concurrent].freeze

  def sanitize_checklist_type(checklist_type)
    raise "Unknown checklist type: #{checklist_type}" unless checklist_type.in?(ALLOWED_CHECKLIST_TYPES)

    checklist_type
  end

  def set_group
    case @container || @checklist&.container
    when Library
      group :library
    when Workspace
      group :workspace
    end
  end
end
