# frozen_string_literal: true

# Ensure Pundit policies and scopes are used and verified
# NB - this is a controller concern, so it should be included in the ApplicationController, but with
# changes Rails defaults it will trigger errors when controllers have no index (e.g. Devise controllers)
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
