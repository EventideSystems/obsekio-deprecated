# frozen_string_literal: true

# Change Checklists from being inside a "container" (either Workspace or Library) and make them
# owned by another record. In the immediate case this will a User record, and for that we will use
# the first admin record found in the system. This isn't ideal, but it gives us a baseline to
# work with.
#
# Later we will allocate Checklists to Organizations as well.

class Workspace < ApplicationRecord; end

class Checklist < ApplicationRecord
  belongs_to :owner, polymorphic: true, optional: true
  belongs_to :container, polymorphic: true, optional: true
end

class User < ApplicationRecord
  belongs_to :personal_workspace, class_name: 'Workspace', dependent: :destroy, optional: true
end

class ChangeChecklistOwnershipFromWorkspaceToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :checklists, :owner, type: :uuid, polymorphic: true, index: true

    reversible do |dir|
      dir.up do
        owner = User.find_by(admin: true)
        Checklist.find_each do |checklist|
          checklist.update!(owner: )
        end
      end

      dir.down do
        container = User.find_by(admin: true).personal_workspace
        Checklist.find_each do |checklist|
          checklist.update!(container: )
        end
      end
    end

    remove_reference :checklists, :container, type: :uuid, index: true
  end

end
