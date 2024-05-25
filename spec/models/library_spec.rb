# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Library, type: :model do
  describe 'system library' do
    let(:library) { described_class.system_library }

    it 'creates a system library if it does not exist' do
      expect(library).to be_persisted
    end

    it 'returns the system library' do
      expect(library).to eq(described_class.system_library)
    end

    it 'does not allow creating a library with the name "System Library"' do
      library = described_class.new(name: 'System Library')

      expect(library).not_to be_valid
    end
  end
end
