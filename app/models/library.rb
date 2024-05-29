# frozen_string_literal: true

# == Schema Information
#
# Table name: libraries
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  owner_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :uuid
#
# Indexes
#
#  index_libraries_on_owner                    (owner_type,owner_id)
#  index_libraries_on_owner_id_and_owner_type  (owner_id,owner_type)
#
# A library is a container for checklists. It can be owned by a user or by the system as a whole.
# Libraries can be shared with other users, and template checklists can be created within them.
class Library < ApplicationRecord
  SYSTEM_LIBRARY_NAME = 'System Library'

  belongs_to :owner, polymorphic: true, optional: true

  has_many :checklists, class_name: 'Checklist', inverse_of: :container, dependent: :destroy

  validates :name, presence: true, exclusion: { in: [SYSTEM_LIBRARY_NAME] }

  class << self
    # Returns the system library - a library that is shared across all users.
    # @return [Library]
    def system_library
      find_by(name: SYSTEM_LIBRARY_NAME) || create_system_library
    end

    private

    def create_system_library
      new(name: SYSTEM_LIBRARY_NAME).tap { |library| library.save(validate: false) }
    end
  end
end
