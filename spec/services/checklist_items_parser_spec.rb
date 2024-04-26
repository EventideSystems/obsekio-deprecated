# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChecklistItemsParser do
  describe '#parse' do
    let(:markdown) { "- [x] Item 1\n- [ ] Item 2\n- [*] Item 3\n * [ ] Item 4" }
    let(:parser) { described_class.new(markdown) }

    let(:items) { parser.parse }

    it 'returns an array of checklist items' do
      expect(items.size).to eq(4)
    end

    # rubocop:disable RSpec/ExampleLength
    # rubocop:disable RSpec/MultipleExpectations
    it 'parses the markdown into checklist items' do
      expect(items[0].checked).to be true
      expect(items[0].text).to eq('Item 1')

      expect(items[1].checked).to be false
      expect(items[1].text).to eq('Item 2')

      expect(items[2].checked).to be true
      expect(items[2].text).to eq('Item 3')

      expect(items[3].checked).to be false
      expect(items[3].text).to eq('Item 4')
    end
    # rubocop:enable RSpec/ExampleLength
    # rubocop:enable RSpec/MultipleExpectations
  end
end
