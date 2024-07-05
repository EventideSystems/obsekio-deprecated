class DropLibrariesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table "libraries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "name", null: false
      t.string "owner_type"
      t.uuid "owner_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "public", default: false
      t.index ["owner_id", "owner_type"], name: "index_libraries_on_owner_id_and_owner_type"
      t.index ["owner_type", "owner_id"], name: "index_libraries_on_owner"
    end
  end
end
