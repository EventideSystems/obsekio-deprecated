class AddContentFieldToChecklists < ActiveRecord::Migration[7.1]
  def up
    add_column :checklists, :content, :text

    execute <<~SQL
      update checklists
      set content = action_markdown_markdown_texts.body
      from action_markdown_markdown_texts
      where action_markdown_markdown_texts.record_id = checklists.id
      and action_markdown_markdown_texts.record_type = 'Checklist';
    SQL

  end

  def down
    remove_column :checklists, :content
  end
end
