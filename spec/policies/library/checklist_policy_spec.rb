# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_context'

RSpec.describe Library::ChecklistPolicy, type: :policy do
  let(:policy) { described_class }

  include_context 'with library_checklist records'

  shared_examples_for 'admin access' do
    it { expect(policy).to permit(admin_user, draft_library_checklist) }
    it { expect(policy).to permit(admin_user, published_library_checklist) }
    it { expect(policy).to permit(admin_user, public_published_library_checklist) }
  end

  shared_examples_for 'edit access for users' do
    it { expect(policy).to permit(user, draft_library_checklist) }
    it { expect(policy).not_to permit(user, published_library_checklist) }
    it { expect(policy).not_to permit(user, public_published_library_checklist) }
  end

  permissions :show? do
    it_behaves_like 'admin access'

    it { expect(policy).to permit(user, draft_library_checklist) }
    it { expect(policy).to permit(user, public_published_library_checklist) }
    it { expect(policy).not_to permit(user, published_library_checklist) }
  end

  permissions :create? do
    it { expect(policy).to permit(admin_user, Library::Checklist) }
    it { expect(policy).to permit(user, Library::Checklist) }
  end

  permissions :update? do
    it_behaves_like 'admin access'
    it_behaves_like 'edit access for users'
  end

  permissions :destroy? do
    it_behaves_like 'admin access'
    it_behaves_like 'edit access for users'
  end
end
