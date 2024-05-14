class RemoveChecklistInstancesContent < ActiveRecord::Migration[7.1]
  def change
    remove_column :checklist_instances, :content, :text
  end
end
