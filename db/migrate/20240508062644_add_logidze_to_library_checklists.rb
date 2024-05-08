class AddLogidzeToLibraryChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :library_checklists, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_library_checklists, on: :library_checklists
      end

      dir.down do
        execute <<~SQL
          DROP TRIGGER IF EXISTS "logidze_on_library_checklists" on "library_checklists";
        SQL
      end
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE "library_checklists" as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
        SQL
      end
    end
  end
end
