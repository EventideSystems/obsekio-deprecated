# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Checklist, type: :model do
  let(:assignee) { create(:user) }

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

    let(:checklist) { create(:checklist, assignee:, content:) }
    let(:items) { checklist.items }

    it { expect(items).to all(be_a(ChecklistItem)) }
    it { expect(items.map(&:text)).to eq(['item 1', 'item 2', 'item 3', 'item 4']) }
    it { expect(items.map(&:checked)).to eq([false, false, false, true]) }
  end
end
