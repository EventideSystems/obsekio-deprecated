# frozen_string_literal: true

# Base class for all contexts.

# == Schema Information
#
# Table name: contexts
#
#  id           :uuid             not null, primary key
#  metadata     :jsonb
#  name         :string           not null
#  type         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  workspace_id :uuid             not null
#
# Indexes
#
#  index_contexts_on_workspace_id  (workspace_id)
#
# Foreign Keys
#
#  fk_rails_...  (workspace_id => workspaces.id)
#
class Context < ApplicationRecord
  belongs_to :workspace
  has_many :context_instances, dependent: :destroy

  # Builds a new instance of the context instance, using the context's type as a base.
  # E.g. if the context is a Contexts::Tag, it will build a new ContextInstances::Tag object.
  # @param [Hash] attributes The attributes to use when building the instance.
  # @return [ContextInstance] The new instance.
  def build_instance(attributes = {})
    klass = "ContextInstances::#{self.class.name.demodulize}".constantize
    klass.new(attributes.merge(context: self))
  end
end
