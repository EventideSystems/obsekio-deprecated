# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Checklist, type: :model do
  describe 'single_instance' do
    let(:assignee) { create(:user) }
    let(:content) { '# test' }

    let(:checklist) { create(:workspace_checklist, instance_model:, assignee:, content:) }
    let(:single_instance) { checklist.single_instance }

    let(:instance_model) { 'single' }

    context 'when no instance record exists' do
      let(:instance_model) { 'single' }

      it { expect(single_instance).to be_a(ChecklistInstance) }
      it { expect(single_instance.content.body.to_markdown).to eq(checklist.content.body.to_markdown) }

      it 'creates a new instance automatically' do
        expect { single_instance }.to change(ChecklistInstance, :count).by(1)
      end
    end

    context 'when an instance record exists' do
      before { create(:checklist_instance, checklist:) }

      it 'does not creates a new instance' do
        expect { single_instance }.not_to change(ChecklistInstance, :count)
      end
    end

    context 'when the checklist is not single' do
      let(:instance_model) { 'longitudinal' }

      it { expect(single_instance).to be_nil }
    end
  end
end
