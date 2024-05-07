class AddMetadataToLibraryChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :library_checklists, :metadata, :jsonb, default: {
      '@context': 'https://schema.org',
      '@type': 'CreativeWork',
      'author': {
        '@type': 'Person',
        'name': ''
      },
      'description': '',
      'license': ''
    }
    add_index :library_checklists, :metadata, using: :gin
  end
end
