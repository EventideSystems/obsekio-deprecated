class AddChecklistTypeToLibraryChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :library_checklists, :checklist_type, :string, null: false, default: 'Checklists::Single'
  end
end
