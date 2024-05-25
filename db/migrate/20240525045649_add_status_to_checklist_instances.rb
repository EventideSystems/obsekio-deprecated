class AddStatusToChecklistInstances < ActiveRecord::Migration[7.1]
  def change
    add_column :checklist_instances, :status, :string, null: false, default: 'ready'
  end
end
