class SetupUserPersonalWorkspacesAndLibraries < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :personal_library_id, :uuid, null: true
    add_column :users, :personal_workspace_id, :uuid, null: true

    reversible do |dir|
      dir.up do
        setup_users
      end
    end
  end

  private

  class Library < ApplicationRecord
    self.table_name = 'libraries'
  end

  class Workspace < ApplicationRecord
    self.table_name = 'workspaces'
  end

  class User < ApplicationRecord
    self.table_name = 'users'
  end

  def setup_users
    User.find_each do |user|
      personal_workspace = Workspace.create!(owner_id: user.id, owner_type: 'User', name: 'Personal Workspace')
      personal_library = Library.create!(owner_id: user.id, owner_type: 'User', name: 'Personal Library')
      user.update!(personal_workspace_id: personal_workspace.id, personal_library_id: personal_library.id)
    end
  end
end
