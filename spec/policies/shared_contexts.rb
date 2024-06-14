# frozen_string_literal: true

RSpec.shared_context 'with user contexts' do
  let(:user) { create(:user) }
  let(:user_context) { UserContext.new(user:) }
  let(:other_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let(:admin_user_context) { UserContext.new(user: admin_user) }
end

RSpec.shared_context 'with workspaces' do
  let(:owned_workspace) { create(:workspace, owner: user) }
  let(:other_workspace) { create(:workspace, owner: other_user) }
end
