# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe ChecklistPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:other_user) { create(:user) }
  let(:workspace) { create(:workspace, owner: user) }
  let(:other_workspace) { create(:workspace, owner: other_user) }
  let(:accessible_checklist) { create(:checklist, container: workspace, title: 'Accessible Checklist') }
  let(:other_checklist) { create(:checklist, container: other_workspace, title: 'Other Checklist') }

  describe ChecklistPolicy::Scope do
    let(:scope) { described_class.new(user, Checklist).resolve }

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
      subject { described_class.new(admin, Checklist).resolve }

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
# rubocop:enable RSpec/MultipleMemoizedHelpers
