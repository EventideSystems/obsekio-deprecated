# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contexts::Tag, type: :model do
  describe '.build_instance' do
    let(:user) { create(:user) }
    let(:workspace) { create(:workspace, owner: user) }
    let(:tag) { described_class.create(name: 'tags') }
    let(:instance) { tag.build_instance(name: 'Test', color: 'red', description: 'Test tage') }

    it 'returns a new instance' do
      expect(instance).to be_a(ContextInstances::Tag)
    end

    it 'sets the context' do
      expect(instance.context).to eq(tag)
    end

    it 'sets the name' do
      expect(instance.name).to eq('Test')
    end
  end
end
