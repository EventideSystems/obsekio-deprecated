# frozen_string_literal: true

# Baseline checklist table structure
class CreateChecklists < ActiveRecord::Migration[7.1]
  def change
    create_table :checklists, id: :uuid do |t|
      t.string :type, null: false
      t.string :title
      t.string :status
      t.references :created_by, type: :uuid, foreign_key: { to_table: :users }, null: true
      t.timestamps
    end

    add_index :checklists, :type
    add_index :checklists, :title
    add_index :checklists, :status
  end
end
