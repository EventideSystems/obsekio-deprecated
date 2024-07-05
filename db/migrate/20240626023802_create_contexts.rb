class CreateContexts < ActiveRecord::Migration[7.1]
  def change
    create_table :contexts, id: :uuid do |t|
      t.references :workspace, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false
      t.string :type, null: false
      t.jsonb :metadata, default: {}
      t.timestamps
    end
  end
end
