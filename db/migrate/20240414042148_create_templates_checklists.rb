class CreateTemplatesChecklists < ActiveRecord::Migration[7.1]
  def change
    create_table :templates_checklists, id: :uuid do |t|
      t.string :title
      t.string :status, default: 'draft'
      t.jsonb :metadata, default: {}
      t.references :created_by, type: :uuid, foreign_key: { to_table: :users }, null: true
      t.timestamps
    end

    add_index :templates_checklists, :title
    add_index :templates_checklists, :status
  end
end
