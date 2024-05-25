class MoveChecklistsToWorkspaces < ActiveRecord::Migration[7.1]
  def change
    add_reference :checklists, :container, type: :uuid, null: true, polymorphic: true

    reversible do |dir|
      dir.up do
        move_checklists
      end
    end
  end

  private

  class User < ApplicationRecord
    self.table_name = 'users'
  end

  class Checklist < ApplicationRecord
    self.table_name = 'checklists'
    self.inheritance_column = nil
  end

  def move_checklists
    Checklist.find_each do |checklist|
      user = checklist.assignee_id.present? ? User.find(checklist.assignee_id) : nil

      next unless user.present? && user.personal_workspace_id.present?

      checklist.update!(container_id: user.personal_workspace_id, container_type: 'Workspace')
    end
  end
end
