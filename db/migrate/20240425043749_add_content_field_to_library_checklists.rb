class AddContentFieldToLibraryChecklists < ActiveRecord::Migration[7.1]
  def up
    add_column :library_checklists, :content, :text

    execute <<~SQL
      update library_checklists
      set content = action_markdown_markdown_texts.body
      from action_markdown_markdown_texts
      where action_markdown_markdown_texts.record_id = library_checklists.id
      and action_markdown_markdown_texts.record_type = 'Library::Checklist';
    SQL

  end

  def down
    remove_column :library_checklists, :content
  end
end
