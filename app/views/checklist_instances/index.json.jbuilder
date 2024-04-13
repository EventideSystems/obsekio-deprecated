# frozen_string_literal: true

json.array! @checklist_instances, partial: 'checklist_instances/checklist_instance', as: :checklist_instance
