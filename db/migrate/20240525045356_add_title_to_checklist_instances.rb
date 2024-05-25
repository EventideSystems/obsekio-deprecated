class AddTitleToChecklistInstances < ActiveRecord::Migration[7.1]
  def change
    add_column :checklist_instances, :title, :string, null: true
  end
end
