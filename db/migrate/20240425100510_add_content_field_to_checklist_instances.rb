class AddContentFieldToChecklistInstances < ActiveRecord::Migration[7.1]
  def up
    add_column :checklist_instances, :content, :text

    execute <<~SQL
      update checklist_instances
      set content = action_markdown_markdown_texts.body
      from action_markdown_markdown_texts
      where action_markdown_markdown_texts.record_id = checklist_instances.id
      and action_markdown_markdown_texts.record_type = 'ChecklistInstance';
    SQL

  end

  def down
    remove_column :checklist_instances, :content
  end
end
