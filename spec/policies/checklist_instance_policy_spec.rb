# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_contexts'

RSpec.describe ChecklistInstancePolicy, type: :policy do
  include_context 'with user contexts'

  let(:accessible_checklist) { create(:checklist, owner: user, title: 'Accessible Checklist') }
  let(:other_checklist) { create(:checklist, owner: other_user, title: 'Other Checklist') }
  let(:accessible_checklist_instance) { create(:checklist_instance, checklist: accessible_checklist) }
  let(:other_checklist_instance) { create(:checklist_instance, checklist: other_checklist) }

  describe ChecklistInstancePolicy::Scope do
    let(:scope) { described_class.new(user_context, ChecklistInstance).resolve }

    before do
      accessible_checklist_instance
      other_checklist_instance
    end

    it 'includes instances of accessible checklists' do
      expect(scope).to include(accessible_checklist_instance)
    end

    it 'does not include instances of other checklists' do
      expect(scope).not_to include(other_checklist_instance)
    end

    context 'when user is admin' do
      let(:scope)  { described_class.new(admin_user_context, ChecklistInstance).resolve }

      it 'includes all checklist instances' do
        expect(scope).to include(accessible_checklist_instance, other_checklist_instance)
      end
    end
  end

  describe '#show?' do
    it 'allows viewing instances of accessible checklists' do
      expect(described_class.new(user_context, accessible_checklist_instance).show?).to be true
    end

    it 'disallows viewing instances of other checklists' do
      expect(described_class.new(user_context, other_checklist_instance).show?).to be false
    end
  end

  # let(:user) { User.new }

  # subject { described_class }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :show? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :update? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end
