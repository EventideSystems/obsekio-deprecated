# frozen_string_literal: true

# Support for setting the active navbar item in a controller
module ActiveNavbarItem
  extend ActiveSupport::Concern

  def active_navbar_item
    self.class.instance_variable_get(:@active_navbar_item)
  end

  class_methods do
    def navbar_item(name)
      @active_navbar_item = name
    end
  end

  def navbar_item(name)
    self.class.navbar_item(name)
  end
end
