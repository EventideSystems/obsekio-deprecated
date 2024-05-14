# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChecklistItemEvent, type: :model do
  let(:assignee) { create(:user) }
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

  let(:checklist) { create(:checklist, assignee:, content:) }
  let(:checklist_instance) { create(:checklist_instance, checklist:) }

  describe 'create event' do
    before do
      checklist_instance.prepare_items
      checklist_instance.save!
    end

    let(:checklist_item) { checklist_instance.reload.items[0] }

    it 'updates the checklist instance from unchecked to checked' do
      expect { create(:checklist_item_event, checklist_instance:, index: 0, item_state: { checked: true }) }
        .to change { checklist_instance.reload.items[0].checked }.from(false).to(true)
    end

    it 'updates the checklist instance from checked to unchecked' do
      expect { create(:checklist_item_event, checklist_instance:, index: 1, item_state: { checked: false }) }
        .to change { checklist_instance.reload.items[1].checked }.from(true).to(false)
    end
  end
end
