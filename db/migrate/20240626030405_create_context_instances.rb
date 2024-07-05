class CreateContextInstances < ActiveRecord::Migration[7.1]
  def change
    create_table :context_instances, id: :uuid do |t|
      t.references :context, type: :uuid, null: false, foreign_key: true
      t.jsonb :data, default: {}
      t.timestamps
    end

    add_index :context_instances, :data, using: :gin
  end
end
