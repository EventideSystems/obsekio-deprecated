class AddPublicFieldToLibraryChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :library_checklists, :public, :boolean, default: false
    add_index :library_checklists, :public
  end
end
