class MoveLibraryCheckistsToLibraries < ActiveRecord::Migration[7.1]

  class Library < ApplicationRecord
    self.table_name = 'libraries'

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


  class LibraryChecklist < ApplicationRecord
    self.table_name = 'library_checklists'
    has_logidze

    belongs_to :created_by, class_name: 'User', optional: true

    string_enum :status, %i[draft published archived], default: :draft

    store_accessor :metadata, :name, :description, :author, :license
    attribute :author, :jsonb, default: { '@type': 'Person', name: '' }
    store_accessor :author, :name, prefix: true

    validates :title, presence: true
  end

  class Checklist < ApplicationRecord
    self.table_name = 'checklists'
    self.inheritance_column = nil

    has_logidze
    include ActionView::Helpers::SanitizeHelper

    belongs_to :created_by, class_name: 'User', optional: true
    belongs_to :assignee, polymorphic: true, optional: true

    belongs_to :container, polymorphic: true, optional: true

    has_many :checklist_instances, dependent: :destroy
  end

  def up
    LibraryChecklist.find_each do |library_checklist|
      create_checklist(library_checklist, Library.system_library)
    end
  end

  private

  def create_checklist(library_checklist, library)
    Checklist.create!(
      title: library_checklist.title,
      status: library_checklist.status,
      content: library_checklist.content,
      log_data: library_checklist.log_data,
      metadata: library_checklist.metadata,
      type: library_checklist.checklist_type,
      container_id: library.id,
      container_type: 'Library',
    )
  end
end
