class DropLibraryPublicChecklistsView < ActiveRecord::Migration[7.1]
  def up
    execute 'drop view if exists library_public_checklists'
  end

  def down
    execute <<~SQL
      CREATE VIEW library_public_checklists AS
        SELECT library_checklists.id,
        library_checklists.title,
        library_checklists.status,
        library_checklists.created_by_id,
        library_checklists.created_at,
        library_checklists.updated_at,
        library_checklists.public,
        library_checklists.content,
        library_checklists.metadata,
        library_checklists.log_data
      FROM library_checklists
      WHERE (library_checklists.public = true);
    SQL
  end
end
