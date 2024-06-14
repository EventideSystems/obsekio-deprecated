class AddRadioDataEntryFieldsToChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :checklists, :data_entry_radio_primary_text, :string
    add_column :checklists, :data_entry_radio_primary_color, :string, default: "green", null: false
    add_column :checklists, :data_entry_radio_secondary_text, :string
    add_column :checklists, :data_entry_radio_secondary_color, :string, default: "amber", null: false
    add_column :checklists, :data_entry_radio_additional_states, :jsonb, default: {}
  end
end
