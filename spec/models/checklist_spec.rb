# frozen_string_literal: true

# == Schema Information
#
# Table name: checklists
#
#  id                                 :uuid             not null, primary key
#  assignee_type                      :string
#  content                            :text
#  data_entry_checkbox_checked_color  :string           default("green"), not null
#  data_entry_comments                :string           default(NULL), not null
#  data_entry_input_type              :string           default("checkbox"), not null
#  data_entry_radio_additional_states :jsonb
#  data_entry_radio_primary_color     :string           default("green"), not null
#  data_entry_radio_primary_text      :string
#  data_entry_radio_secondary_color   :string           default("amber"), not null
#  data_entry_radio_secondary_text    :string
#  instance_model_name                :string           default("Instance"), not null
#  log_data                           :jsonb
#  metadata                           :jsonb
#  owner_type                         :string
#  status                             :string
#  title                              :string
#  type                               :string
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  assignee_id                        :uuid
#  owner_id                           :uuid
#
# Indexes
#
#  index_checklists_on_assignee  (assignee_type,assignee_id)
#  index_checklists_on_owner     (owner_type,owner_id)
#  index_checklists_on_status    (status)
#  index_checklists_on_title     (title)
#  index_checklists_on_type      (type)
#
require 'rails_helper'

RSpec.describe Checklist, type: :model do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:owner) { create(:user) }
  let(:title) { 'test' }
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
  let(:checklist) { create(:checklist, owner:, title:, content:, metadata:) }
  let(:items) { checklist.items }

  describe 'items' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it { expect(items).to all(be_a(ChecklistItem)) }
    it { expect(items.map(&:text)).to eq(['item 1', 'item 2', 'item 3', 'item 4']) }
    it { expect(items.map(&:state)).to eq(%w[unchecked unchecked unchecked checked]) }
  end

  describe 'description' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns the description from the metadata' do
      expect(checklist.description).to eq('A description of my creative work')
    end

    it 'sets the description in the metadata' do
      checklist.description = 'New description'
      checklist.save!
      expect(checklist.description).to eq('New description')
    end
  end

  # describe '.data_entry_input_type' do
  #   context "when set to 'checkbox'" do
  #     before do
  #       checklist.data_entry_input_type = 'checkbox'
  #       checklist.data_entry_checkbox_checked_color = 'yellow'
  #       checklist.save!
  #     end

  #     it { expect(items.map(&:state)).to eq(%w[no no no yes]) }
  #   end

  #   context 'radio button item definition' do
  #   end
  # end
end
