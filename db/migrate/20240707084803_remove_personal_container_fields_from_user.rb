class RemovePersonalContainerFieldsFromUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :personal_workspace_id, type: :uuid
    remove_column :users, :personal_library_id, type: :uuid
  end
end
