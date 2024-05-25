class CreateWorkspaces < ActiveRecord::Migration[7.1]
  def change
    create_table :workspaces, id: :uuid do |t|
      t.string :name, null: false
      t.references :owner, null: false, polymorphic: true, type: :uuid
      t.timestamps
    end

    add_index :workspaces, [:owner_id, :owner_type]
  end
end
