class Workspace < ApplicationRecord

end

class User < ApplicationRecord
  belongs_to :personal_workspace, class_name: 'Workspace', dependent: :destroy, optional: true

  def setup_personal_workspace
    Workspace.create!(owner: self, name: 'Personal Workspace').tap do |workspace|
      update!(personal_workspace: workspace)
    end
  end
end

class DropWorkspacesTable < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.down do
        User.find_each { |user| user.setup_personal_workspace}
      end
    end

    drop_table "workspaces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "name"
      t.string "owner_type", null: false
      t.uuid "owner_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["owner_id", "owner_type"], name: "index_workspaces_on_owner_id_and_owner_type"
      t.index ["owner_type", "owner_id"], name: "index_workspaces_on_owner"
    end
  end
end
