# frozen_string_literal: true

# == Schema Information
#
# Table name: checklist_item_events
#
#  id                    :uuid             not null, primary key
#  index                 :integer          not null
#  item_state            :jsonb            not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  checklist_instance_id :uuid             not null
#  true_user_id          :uuid
#  user_id               :uuid
#
# Indexes
#
#  index_checklist_item_events_on_checklist_instance_id  (checklist_instance_id)
#  index_checklist_item_events_on_true_user_id           (true_user_id)
#  index_checklist_item_events_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (checklist_instance_id => checklist_instances.id)
#  fk_rails_...  (true_user_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :checklist_item_event do
  end
end
