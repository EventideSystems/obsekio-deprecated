class AddDataEntryCommentsToChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :checklists, :data_entry_comments, :string, default: 'disabled', null: false
  end
end
