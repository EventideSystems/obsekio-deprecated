# frozen_string_literal: true

# Base controller
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include ControllerGroups

  layout :layout_by_resource

  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :deny_access
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::InvalidAuthenticityToken, with: :reset_session_and_redirect

  impersonates :user

  group :root

  helper_method :breadcrumbs

  def pundit_user
    UserContext.new(user: current_user, true_user:)
  end

  alias user_context pundit_user

  private

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:invite, keys: [:email])
  end

  def deny_access
    redirect_back fallback_location: root_path, alert: I18n.t('alerts.access_denied')
  end

  def layout_by_resource = devise_controller? ? 'devise' : 'application'

  def record_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  def reset_session_and_redirect
    reset_session
    redirect_to root_path, alert: I18n.t('alerts.session_expired')
  end

  def use_logidze_responsible(&block)
    Logidze.with_responsible(current_user&.id, &block)
  end
end
