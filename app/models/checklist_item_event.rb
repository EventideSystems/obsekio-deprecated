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
#
# Indexes
#
#  index_checklist_item_events_on_checklist_instance_id  (checklist_instance_id)
#
# Foreign Keys
#
#  fk_rails_...  (checklist_instance_id => checklist_instances.id)
#
class ChecklistItemEvent < ApplicationRecord
  belongs_to :checklist_instance

  validates :checklist_instance, presence: true
  validates :index, presence: true
  validates :item_state, presence: true

  after_create :update_checklist_instance

  private

  def update_checklist_instance
    checklist_instance.update_checklist_item(event: self)
  end
end
