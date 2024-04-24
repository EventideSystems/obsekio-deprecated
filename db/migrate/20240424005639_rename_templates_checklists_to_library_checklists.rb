class RenameTemplatesChecklistsToLibraryChecklists < ActiveRecord::Migration[7.1]
  def change
    rename_table :templates_checklists, :library_checklists
  end
end
