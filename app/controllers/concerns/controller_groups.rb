# frozen_string_literal: true

# Support for grouping controllers, used by the sideabar navigation to identify the active controller group
module ControllerGroups
  extend ActiveSupport::Concern

  def active_group
    self.class.instance_variable_get(:@group)
  end

  class_methods do
    def group(name)
      @group = name
    end
  end
end
