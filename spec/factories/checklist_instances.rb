# frozen_string_literal: true

# == Schema Information
#
# Table name: checklist_instances
#
#  id            :uuid             not null, primary key
#  assignee_type :string
#  item_states   :jsonb            is an Array
#  log_data      :jsonb
#  status        :string           default("ready"), not null
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assignee_id   :uuid
#  checklist_id  :uuid             not null
#
# Indexes
#
#  index_checklist_instances_on_assignee      (assignee_type,assignee_id)
#  index_checklist_instances_on_checklist_id  (checklist_id)
#
# Foreign Keys
#
#  fk_rails_...  (checklist_id => checklists.id)
#
FactoryBot.define do
  factory :checklist_instance do
  end
end
