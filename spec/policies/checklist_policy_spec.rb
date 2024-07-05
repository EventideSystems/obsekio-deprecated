# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_contexts'

RSpec.describe ChecklistPolicy, type: :policy do
  subject { described_class }

  include_context 'with user contexts'

  let(:accessible_checklist) { create(:checklist, owner: user, title: 'Accessible Checklist') }
  let(:other_checklist) { create(:checklist, owner: other_user, title: 'Other Checklist') }

  describe ChecklistPolicy::Scope do
    let(:scope) { described_class.new(user_context, Checklist).resolve }

    before do
      accessible_checklist
      other_checklist
    end

    it 'includes instances of accessible checklists' do
      expect(scope).to include(accessible_checklist)
    end

    it 'does not include instances of other checklists' do
      expect(scope).not_to include(other_checklist)
    end

    context 'when user is admin' do
      let(:scope) { described_class.new(admin_user_context, Checklist).resolve }

      it 'includes all checklist instances' do
        expect(scope).to include(accessible_checklist, other_checklist)
      end
    end
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
