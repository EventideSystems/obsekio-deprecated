# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_context'

RSpec.describe Library::ChecklistPolicy::Scope, type: :policy do
  include_context 'with library_checklist records'

  permissions '.scope' do
    context 'when user is an admin' do
      let(:scope) { described_class.new(admin_user, Library::Checklist).resolve }

      it 'returns all records' do
        expect(scope).to eq(Library::Checklist.all)
      end
    end

    context 'when user is not an admin' do
      let(:scope) { described_class.new(user, Library::Checklist).resolve }

      it 'returns published public records, or those owned by the user' do
        expect(scope).to include(public_published_library_checklist, draft_library_checklist)
      end

      it 'does not return published records that are not public and not owned by the user' do
        expect(scope).not_to include(published_library_checklist)
      end
    end
  end
end
