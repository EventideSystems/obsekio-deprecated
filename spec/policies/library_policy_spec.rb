# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe LibraryPolicy, type: :policy do
#   let(:user) { User.new }

#   subject { described_class }

#   permissions ".scope" do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end

#   permissions :show? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end

#   permissions :create? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end

#   permissions :update? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end

#   permissions :destroy? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end
# end

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe LibraryPolicy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:public_library) { create(:library, public: true, name: 'Public Library') }
  let(:personal_library) { create(:library, owner: user, name: 'Personal Library') }
  let(:other_library) { create(:library, owner: other_user, name: 'Other Personal Library') }

  describe LibraryPolicy::Scope do
    let(:scope) { described_class.new(user, Library).resolve }

    it 'includes public libraries' do
      expect(scope).to include(public_library)
    end

    it 'includes personal libraries' do
      expect(scope).to include(personal_library)
    end

    it 'does not include other libraries' do
      expect(scope).not_to include(other_library)
    end
  end

  describe '#show?' do
    it 'allows viewing public libraries' do
      expect(described_class.new(user, public_library).show?).to be true
    end

    it 'allows viewing personal libraries' do
      expect(described_class.new(user, personal_library).show?).to be true
    end

    it 'disallows viewing other libraries' do
      expect(described_class.new(user, other_library).show?).to be false
    end
  end

  describe '#personal?' do
    it 'returns true for personal libraries' do
      expect(described_class.new(user, personal_library).personal?).to be true
    end

    it 'returns false for other libraries' do
      expect(described_class.new(user, other_library).personal?).to be false
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
