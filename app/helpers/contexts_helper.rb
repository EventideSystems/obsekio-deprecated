# frozen_string_literal: true

# Helper methods for Contexts and related models
module ContextsHelper
  def options_for_context_type_select
    [
      Contexts::Tag,
      Contexts::Contact
    ].map { |type| [type.model_name.human, type.to_s] }
  end
end
