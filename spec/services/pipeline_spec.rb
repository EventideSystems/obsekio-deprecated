# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pipeline, type: :model do
  describe 'simple checklist' do
    let(:markdown) do
      <<~MARKDOWN
        unordered task list

        - [ ] first ul task item
        - [x] second ul task item
        - [X] third ul task item
        - [ ] fourth ul task item
      MARKDOWN
    end

    it 'returns a string' do # rubocop:disable RSpec/ExampleLength
      expect(described_class.new.call(markdown)[:output]).to eq(
        "<p>unordered task list</p>\n" \
        "<ul>\n" \
        "<li><input type=\"checkbox\" disabled=\"\" /> first ul task item</li>\n" \
        "<li><input type=\"checkbox\" checked=\"\" disabled=\"\" /> second ul task item</li>\n" \
        "<li><input type=\"checkbox\" checked=\"\" disabled=\"\" /> third ul task item</li>\n" \
        "<li><input type=\"checkbox\" disabled=\"\" /> fourth ul task item</li>\n" \
        '</ul>'
      )
    end
  end
end
