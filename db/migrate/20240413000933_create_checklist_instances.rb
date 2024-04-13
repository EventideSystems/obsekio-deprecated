class CreateChecklistInstances < ActiveRecord::Migration[7.1]
  def change
    create_table :checklist_instances, id: :uuid do |t|
      t.references :checklist, null: false, foreign_key: true, type: :uuid
      t.references :assignee, polymorphic: true, null: true, type: :uuid
      t.timestamps
    end
  end
end
