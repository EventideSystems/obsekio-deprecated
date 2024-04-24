# frozen_string_literal: true

module Library
  # ChecklistsHelper
  module ChecklistsHelper
    def render_visibility_badge(checklist)
      render partial: '/library/shared/visibilty_badge', locals: { text: checklist.public? ? 'Public' : 'Private' }
    end
  end
end

# app/views/library/shared/_visibilty_badge.erb
