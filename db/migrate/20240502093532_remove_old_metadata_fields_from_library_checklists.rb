class RemoveOldMetadataFieldsFromLibraryChecklists < ActiveRecord::Migration[7.1]
  def change
    remove_column :library_checklists, :contributor, :string
    remove_column :library_checklists, :creator, :string
    remove_column :library_checklists, :description, :string
    remove_column :library_checklists, :format, :string, default: 'text/markdown'
    remove_column :library_checklists, :language, :string, default: 'en'
    remove_column :library_checklists, :publisher, :string
    remove_column :library_checklists, :rights, :string
    remove_column :library_checklists, :source, :string
    remove_column :library_checklists, :title_alternative, :string
  end
end
