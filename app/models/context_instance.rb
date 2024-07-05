# frozen_string_literal: true

# Base class for all context instances.

# == Schema Information
#
# Table name: context_instances
#
#  id         :uuid             not null, primary key
#  data       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  context_id :uuid             not null
#
# Indexes
#
#  index_context_instances_on_context_id  (context_id)
#  index_context_instances_on_data        (data) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (context_id => contexts.id)
#
class ContextInstance < ApplicationRecord
  belongs_to :context
  delegate :workspace, to: :context
end
