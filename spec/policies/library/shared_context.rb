# frozen_string_literal: true

RSpec.shared_context 'with library_checklist records' do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }

  let(:draft_library_checklist) { create(:library_checklist, title: 'Draft', status: 'draft', created_by: user) }

  let(:published_library_checklist) do
    create(:library_checklist, title: 'Published', status: 'published', public: false, created_by: admin_user)
  end
  let(:public_published_library_checklist) do
    create(:library_checklist, title: 'Published', status: 'published', public: true, created_by: admin_user)
  end

  # Create some records before running the tests
  before do
    draft_library_checklist
    published_library_checklist
    public_published_library_checklist
  end
end
