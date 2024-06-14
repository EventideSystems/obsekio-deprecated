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
require 'rails_helper'

RSpec.describe ChecklistInstance, type: :model do
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
  let(:title) { 'Getting Started Checklist' }

  let(:checklist) { create(:checklist, assignee:, content:, title:) }

  describe 'prepare_items' do
    let(:checklist_instance) { build(:checklist_instance, checklist:) }

    before { checklist_instance.prepare_items }

    it { expect(checklist_instance.items.count).to eq(5) }
    it { expect(checklist_instance.items[0].state).to eq('unchecked') }
    it { expect(checklist_instance.items[1].state).to eq('checked') }
    it { expect(checklist_instance.items[2].state).to eq('unchecked') }
    it { expect(checklist_instance.items[3].state).to eq('checked') }
    it { expect(checklist_instance.items[4].state).to eq('checked') }
  end
end
