# frozen_string_literal: true

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
