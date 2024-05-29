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
require 'rails_helper'

RSpec.describe Checklist, type: :model do
  let(:assignee) { create(:user) }
  let(:title) { 'test' }

  describe 'items' do
    let(:content) do
      <<~CONTENT
        # test
        ## Group 1
        - [ ] item 1
        - [ ] item 2
        ## Group 2
        - [ ] item 3
        - [x] item 4
      CONTENT
    end

    let(:checklist) { create(:checklist, assignee:, title:, content:) }
    let(:items) { checklist.items }

    it { expect(items).to all(be_a(ChecklistItem)) }
    it { expect(items.map(&:text)).to eq(['item 1', 'item 2', 'item 3', 'item 4']) }
    it { expect(items.map(&:checked)).to eq([false, false, false, true]) }
  end

  describe 'description' do
    let(:checklist) { create(:checklist, assignee:, title:, metadata:) }

    let(:metadata) do
      {
        "name": 'My Creative Work',
        "description": 'A description of my creative work',
        "author": {
          "@type": 'Person',
          "name": 'My Name'
        }
      }
    end

    it 'returns the description from the metadata' do
      expect(checklist.description).to eq('A description of my creative work')
    end

    it 'sets the description in the metadata' do
      checklist.description = 'New description'
      checklist.save!
      expect(checklist.description).to eq('New description')
    end
  end
end
