class AddCheckboxDataEntryFieldsToChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :checklists, :data_entry_input_type, :string, default: "checkbox", null: false
    add_column :checklists, :data_entry_checkbox_checked_color, :string, default: "green", null: false
  end
end
