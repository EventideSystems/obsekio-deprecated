# frozen_string_literal: true

# == Schema Information
#
# Table name: checklists
#
#  id             :uuid             not null, primary key
#  assignee_type  :string
#  container_type :string
#  content        :text
#  log_data       :jsonb
#  metadata       :jsonb
#  status         :string
#  title          :string
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  assignee_id    :uuid
#  container_id   :uuid
#  created_by_id  :uuid
#
# Indexes
#
#  index_checklists_on_assignee       (assignee_type,assignee_id)
#  index_checklists_on_container      (container_type,container_id)
#  index_checklists_on_created_by_id  (created_by_id)
#  index_checklists_on_status         (status)
#  index_checklists_on_title          (title)
#  index_checklists_on_type           (type)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#
module Checklists
  # Checklist model for concurrent checklists.
  #
  # Concurrent checklists may have multiple checklist instances open at any one time.
  #
  # @see Checklist
  class Concurrent < Checklist
  end
end
