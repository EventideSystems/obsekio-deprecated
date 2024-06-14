# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarkdownRenderer do
  let(:content) do
    <<~CONTENT
      unordered task list

      - [ ] first ul task item
      - [x] second ul task item
      - [X] third ul task item
      - [ ] fourth ul task item
    CONTENT
  end

  describe 'simple checklist' do
    it 'returns a string' do # rubocop:disable RSpec/ExampleLength
      expect(described_class.new.call(content)).to eq(
        "<p>unordered task list</p>\n" \
        "<ul>\n" \
        "<li><input type=\"checkbox\" /> first ul task item</li>\n" \
        "<li><input type=\"checkbox\" checked=\"\" /> second ul task item</li>\n" \
        "<li><input type=\"checkbox\" checked=\"\" /> third ul task item</li>\n" \
        "<li><input type=\"checkbox\" /> fourth ul task item</li>\n" \
        '</ul>'
      )
    end
  end

  describe 'with checklist object, using checkboxes' do
    let(:checklist) { build(:checklist, content:, data_entry_checkbox_checked_color: 'yellow') }
    let(:checklist_instance) { build(:checklist_instance, checklist:) }
    let(:expected_html) do
      <<~HTML.squish
        <ul>
        <li><input type="checkbox" class="mr-2 h-4 w-4 rounded border-gray-300 text-yellow-700 focus:ring-yellow-700" /> first ul task item</li>
        <li><input type="checkbox" checked="checked" class="mr-2 h-4 w-4 rounded border-gray-300 text-yellow-700 focus:ring-yellow-700" /> second ul task item</li>
        <li><input type="checkbox" checked="checked" class="mr-2 h-4 w-4 rounded border-gray-300 text-yellow-700 focus:ring-yellow-700" /> third ul task item</li>
        <li><input type="checkbox" class="mr-2 h-4 w-4 rounded border-gray-300 text-yellow-700 focus:ring-yellow-700" /> fourth ul task item</li>
        </ul>
      HTML
    end
    let(:generated_html) { described_class.new.call(content, checklist_instance) }

    before do
      checklist_instance.prepare_items
    end

    it 'returns correct HTML' do
      expect(generated_html.gsub(/\n/, ' ')).to include(expected_html)
    end
  end

  describe 'with checklist object, using radios' do
    let(:checklist) do
      build(
        :checklist,
        content:,
        data_entry_input_type: :radio,
        data_entry_radio_primary_text: 'Yes',
        data_entry_radio_primary_color: 'green',
        data_entry_radio_secondary_text: 'No',
        data_entry_radio_secondary_color: 'yellow',
        data_entry_radio_additional_states: [
          { text: 'N/A', color: 'indigo' }
        ]
      )
    end

    let(:checklist_instance) { build(:checklist_instance, checklist:) }
    let(:expected_html) do
      <<~HTML.squish
        <li><input type="radio" class="mr-2 h-4 w-4 border-gray-300 text-green-700 focus:ring-green-700" name="first_ul_task_item" id="first_ul_task_item_primary" value="Yes" title="Yes" /><input type="radio" name="first_ul_task_item" id="first_ul_task_item_secondary" value="No" title="No" class="mr-2 h-4 w-4 border-gray-300 text-yellow-700 focus:ring-yellow-700"><\/input><input type="radio" name="first_ul_task_item" id="first_ul_task_item_3rd" value="N/A" class="mr-2 h-4 w-4 border-gray-300 text-indigo-700 focus:ring-indigo-700"><\/input> first ul task item</li>
        <li><input type="radio" class="mr-2 h-4 w-4 border-gray-300 text-green-700 focus:ring-green-700" name="second_ul_task_item" id="second_ul_task_item_primary" value="Yes" title="Yes" checked="checked" /><input type="radio" name="second_ul_task_item" id="second_ul_task_item_secondary" value="No" title="No" class="mr-2 h-4 w-4 border-gray-300 text-yellow-700 focus:ring-yellow-700"><\/input><input type="radio" name="second_ul_task_item" id="second_ul_task_item_3rd" value="N/A" class="mr-2 h-4 w-4 border-gray-300 text-indigo-700 focus:ring-indigo-700"><\/input> second ul task item</li>
        <li><input type="radio" class="mr-2 h-4 w-4 border-gray-300 text-green-700 focus:ring-green-700" name="third_ul_task_item" id="third_ul_task_item_primary" value="Yes" title="Yes" checked="checked" /><input type="radio" name="third_ul_task_item" id="third_ul_task_item_secondary" value="No" title="No" class="mr-2 h-4 w-4 border-gray-300 text-yellow-700 focus:ring-yellow-700"><\/input><input type="radio" name="third_ul_task_item" id="third_ul_task_item_3rd" value="N/A" class="mr-2 h-4 w-4 border-gray-300 text-indigo-700 focus:ring-indigo-700"><\/input> third ul task item</li>
        <li><input type="radio" class="mr-2 h-4 w-4 border-gray-300 text-green-700 focus:ring-green-700" name="fourth_ul_task_item" id="fourth_ul_task_item_primary" value="Yes" title="Yes" /><input type="radio" name="fourth_ul_task_item" id="fourth_ul_task_item_secondary" value="No" title="No" class="mr-2 h-4 w-4 border-gray-300 text-yellow-700 focus:ring-yellow-700"><\/input><input type="radio" name="fourth_ul_task_item" id="fourth_ul_task_item_3rd" value="N/A" class="mr-2 h-4 w-4 border-gray-300 text-indigo-700 focus:ring-indigo-700"><\/input> fourth ul task item</li>
      HTML
    end
    let(:generated_html) { described_class.new.call(content, checklist_instance) }

    before do
      checklist_instance.prepare_items
    end

    it 'returns correct HTML' do
      expect(generated_html.gsub(/\n/, ' ')).to include(expected_html)
    end
  end
end
