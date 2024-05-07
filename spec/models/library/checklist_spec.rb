# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Library::Checklist, type: :model do
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

  let(:checklist) { create(:library_checklist, title: 'test', metadata:) }

  describe 'description' do
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
