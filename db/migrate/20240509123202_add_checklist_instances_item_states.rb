class AddChecklistInstancesItemStates < ActiveRecord::Migration[7.1]
  def change
    add_column :checklist_instances, :item_states, :jsonb, default: [], array: true
  end
end
