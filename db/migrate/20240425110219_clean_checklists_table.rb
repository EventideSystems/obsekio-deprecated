class CleanChecklistsTable < ActiveRecord::Migration[7.1]
  def up
    execute <<~SQL
      delete from checklists where type <> 'Workspace::Checklist';
    SQL
  end

  def down
    # NO OP
  end
end
