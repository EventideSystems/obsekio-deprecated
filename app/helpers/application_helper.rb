# frozen_string_literal: true

# Common helper methods for the application
module ApplicationHelper
  # Render a Recaptcha v3 script tag, with a nonce, using the recaptcha_v3 helper from the recaptcha gem
  def recaptcha_with_nonce(action: nil)
    return if Recaptcha.configuration.site_key.blank?

    recaptcha_v3(action:, nonce: SecureRandom.base64(32))
  end

  # Render an SVG icon from views/icons
  # Source: https://www.writesoftwarewell.com/how-to-render-svg-icons-in-rails
  def render_icon(icon, classes: '')
    render "layouts/shared/icons/#{icon}", classes:
  end

  def render_sidebar_item(title:, path:, icon:, active_group:, classes: '', count: nil) # rubocop:disable Metrics/ParameterLists
    active = active_group == controller.active_group

    render 'layouts/shared/sidebar_item', title:, path:, icon:, active:, classes:, count:
  end

  def render_navbar_item(title:, path:, icon:, active_group:, classes: '')
    active = active_group == controller.active_group

    render 'layouts/shared/navbar_item', title:, path:, icon:, active:, classes:
  end

  def link_to_tab_item(title, path, active_action_name)
    klass = controller.action_name == active_action_name.to_s ? 'text-yellow-400' : ''

    return content_tag(:span, title, class: klass) if path.blank?

    link_to title, path, class: klass
  end
end
