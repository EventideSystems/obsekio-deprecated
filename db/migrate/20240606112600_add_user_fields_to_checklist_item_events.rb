class AddUserFieldsToChecklistItemEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :checklist_item_events, :user, null: true, type: :uuid, foreign_key: true
    add_reference :checklist_item_events, :true_user, null: true, type: :uuid, foreign_key: { to_table: :users }
  end
end
