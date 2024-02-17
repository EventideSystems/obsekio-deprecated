# frozen_string_literal: true

# Ensure Pundit policies and scopes are used
module VerifyPundit
  extend ActiveSupport::Concern

  included do
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
  end
end
