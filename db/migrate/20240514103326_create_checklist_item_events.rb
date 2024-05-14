class CreateChecklistItemEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :checklist_item_events, id: :uuid do |t|
      t.references :checklist_instance, null: false, foreign_key: true, type: :uuid
      t.integer :index, null: false
      t.jsonb :item_state, null: false
      t.timestamps
    end
  end
end
