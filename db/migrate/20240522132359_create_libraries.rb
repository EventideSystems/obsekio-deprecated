class CreateLibraries < ActiveRecord::Migration[7.1]
  def change
    create_table :libraries, id: :uuid do |t|
      t.string :name, null: false
      t.references :owner, null: true, polymorphic: true, type: :uuid
      t.timestamps
    end

    add_index :libraries, [:owner_id, :owner_type]
  end
end
