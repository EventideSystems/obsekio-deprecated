class CreateLibraryPublicChecklists < ActiveRecord::Migration[7.1]
  def change
    create_view :library_public_checklists
  end
end
