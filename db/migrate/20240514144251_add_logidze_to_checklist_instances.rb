class AddLogidzeToChecklistInstances < ActiveRecord::Migration[7.1]
  def change
    add_column :checklist_instances, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_checklist_instances, on: :checklist_instances
      end

      dir.down do
        execute <<~SQL
          DROP TRIGGER IF EXISTS "logidze_on_checklist_instances" on "checklist_instances";
        SQL
      end
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE "checklist_instances" as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
        SQL
      end
    end
  end
end
