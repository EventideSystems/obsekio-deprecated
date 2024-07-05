# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContextInstances::Tag, type: :model do
  let(:user) { create(:user) }
  let(:workspace) { create(:workspace, owner: user) }
  let(:context) { Contexts::Tag.create(name: 'tags', workspace:) }

  describe '#validate_name_uniqueness' do
    before do
      described_class.create!(name: 'UniqueName', color: 'red', description: 'A description', context:)
      new_tag.validate
    end

    context 'when a tag with the same name exists in the same context' do
      let(:new_tag) do
        described_class.new(name: 'UniqueName', color: 'blue', description: 'Another description', context:)
      end

      it { expect(new_tag.valid?).to be false }
      it { expect(new_tag.errors[:name]).to include('has already been taken in this context.') }
    end

    context 'when a tag with the same name exists in a different context' do
      let(:other_context) { Contexts::Tag.create(name: 'other tags', workspace:) }
      let(:new_tag) do
        described_class.new(
          name: 'UniqueName',
          color: 'blue',
          description: 'Another description',
          context: other_context
        )
      end

      it { expect(new_tag.valid?).to be true }
    end

    context 'when a tag with a different name exists in the same context' do
      let(:new_tag) do
        described_class.new(
          name: 'AnotherName',
          color: 'blue',
          description: 'Another description',
          context:
        )
      end

      it { expect(new_tag.valid?).to be true }
    end
  end
end
