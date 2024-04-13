# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChecklistInstance, type: :model do
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

  describe 'checklist items' do
    let(:checklist_instance) { build(:checklist_instance, content:) }

    it { expect(checklist_instance.checklist_items.count).to eq(5) }
    it { expect(checklist_instance.checklist_items[0].checked).to be_falsey }
    it { expect(checklist_instance.checklist_items[1].checked).to be_truthy }
    it { expect(checklist_instance.checklist_items[2].checked).to be_falsey }
    it { expect(checklist_instance.checklist_items[3].checked).to be_truthy }
    it { expect(checklist_instance.checklist_items[4].checked).to be_truthy }
  end

  describe 'updating a checklist item' do
    let(:checklist_instance) { build(:checklist_instance, content:) }

    it 'updates the checklist item' do
      checklist_item = checklist_instance.checklist_items.first
      checklist_item.checked = true
      checklist_instance.update_checklist_item(checklist_item)

      expect(checklist_instance.checklist_items.first.checked).to be_truthy
    end
  end
end
