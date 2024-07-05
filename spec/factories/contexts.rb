# frozen_string_literal: true

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
FactoryBot.define do
  factory :context do
  end
end
