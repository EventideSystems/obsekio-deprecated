# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Templates::ChecklistPolicy, type: :policy do
  let(:policy) { described_class }

  let(:user) { User.new }
  let(:admin_user) { User.new(admin: true) }

  let(:draft_templates_checklist) { create(:templates_checklist, status: 'draft') }
  let(:published_templates_checklist) { create(:templates_checklist, status: 'published') }

  permissions '.scope' do
    context 'when user is an admin' do
      it 'returns all records' do
        expect(policy::Scope.new(admin_user, Templates::Checklist).resolve).to eq(Templates::Checklist.all)
      end
    end

    context 'when user is not an admin' do
      it 'returns only published records' do
        expect(policy::Scope.new(user,
                                 Templates::Checklist).resolve).to eq(Templates::Checklist.where(status: 'published'))
      end
    end
  end

  shared_examples_for 'admin access' do
    it { expect(policy).to permit(admin_user, draft_templates_checklist) }
    it { expect(policy).to permit(admin_user, published_templates_checklist) }
  end

  shared_examples_for 'no access for users' do
    it { expect(policy).not_to permit(user, draft_templates_checklist) }
    it { expect(policy).not_to permit(user, published_templates_checklist) }
  end

  permissions :show? do
    it_behaves_like 'admin access'

    it { expect(policy).not_to permit(user, draft_templates_checklist) }
    it { expect(policy).to permit(user, published_templates_checklist) }
  end

  permissions :create? do
    it_behaves_like 'admin access'
    it_behaves_like 'no access for users'
  end

  permissions :update? do
    it_behaves_like 'admin access'
    it_behaves_like 'no access for users'
  end

  permissions :destroy? do
    it_behaves_like 'admin access'
    it_behaves_like 'no access for users'
  end
end
