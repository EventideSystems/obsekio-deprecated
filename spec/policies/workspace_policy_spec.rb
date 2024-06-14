# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_contexts'

RSpec.describe WorkspacePolicy do
  include_context 'with user contexts'
  include_context 'with workspaces'

  describe WorkspacePolicy::Scope do
    let(:scope) { described_class.new(user_context, Workspace).resolve }

    it 'includes workspaces owned by the user' do
      expect(scope).to include(owned_workspace)
    end

    it 'does not include workspaces owned by other users' do
      expect(scope).not_to include(other_workspace)
    end
  end

  describe '#show?' do
    it 'allows viewing owned workspaces' do
      expect(described_class.new(user_context, owned_workspace).show?).to be true
    end

    it 'disallows viewing other workspaces' do
      expect(described_class.new(user_context, other_workspace).show?).to be false
    end
  end

  describe '#personal?' do
    it 'returns true for owned workspaces' do
      expect(described_class.new(user_context, owned_workspace).personal?).to be true
    end

    it 'returns false for other workspaces' do
      expect(described_class.new(user_context, other_workspace).personal?).to be false
    end
  end
end
