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
require 'rails_helper'

RSpec.describe ChecklistItemEvent, type: :model do
  let(:owner) { create(:user) }
  let(:content) do
    <<~CONTENT
      # Welcome to Obsekio!

      We're excited to have you on board! Here are a few things you should do to get started:
      - [ ] Review your [Account Settings](/settings/account)
      - [*] Read the [Obsekio Handbook](https://handbook.obsekio.com)
      - [ ] Watch the [Obsekio Onboarding Video](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
      - [x] Join the #general channel on Slack
      - [X] Complete the [Obsekio Training Course](https://training.obsekio.com)

      Feel free to check things off as you go. If you have any questions, don't hesitate to ask!
    CONTENT
  end
  let(:title) { 'Getting Started Checklist' }

  let(:checklist) { create(:checklist, owner:, content:, title:) }
  let(:checklist_instance) { create(:checklist_instance, checklist:) }

  describe 'create event' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    before do
      checklist_instance.prepare_items
      checklist_instance.save!
    end

    let(:checklist_item) { checklist_instance.reload.items[0] }

    it 'updates the checklist instance from unchecked to checked' do
      expect { create(:checklist_item_event, checklist_instance:, index: 0, item_state: { state: 'checked' }) }
        .to change { checklist_instance.reload.items[0].state }.from('unchecked').to('checked')
    end

    it 'updates the checklist instance from checked to unchecked' do
      expect { create(:checklist_item_event, checklist_instance:, index: 1, item_state: { state: 'unchecked' }) }
        .to change { checklist_instance.reload.items[1].state }.from('checked').to('unchecked')
    end
  end
end
