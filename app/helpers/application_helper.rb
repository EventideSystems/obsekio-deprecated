# frozen_string_literal: true

# Common helper methods for the application
module ApplicationHelper
  # Render an SVG icon from views/icons
  # Source: https://www.writesoftwarewell.com/how-to-render-svg-icons-in-rails
  def render_icon(icon, classes: '')
    render "layouts/shared/icons/#{icon}", classes:
  end

  def render_sidebar_item(title:, path:, icon:, active_group:, classes: '')
    active = active_group == controller.active_group

    render 'layouts/shared/sidebar_item', title:, path:, icon:, active:, classes:
  end
end
