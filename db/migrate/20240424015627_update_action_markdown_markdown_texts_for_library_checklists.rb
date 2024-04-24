class UpdateActionMarkdownMarkdownTextsForLibraryChecklists < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      UPDATE action_markdown_markdown_texts set record_type = 'Library::Checklist' WHERE record_type = 'Templates::Checklist';
    SQL
  end

  def down
    execute <<-SQL
      UPDATE action_markdown_markdown_texts set record_type = 'Templates::Checklist' WHERE record_type = 'Library::Checklist';
    SQL
  end
end
