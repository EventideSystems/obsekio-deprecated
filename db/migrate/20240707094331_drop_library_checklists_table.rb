class DropLibraryChecklistsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table "library_checklists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "title"
      t.string "status", default: "draft"
      t.uuid "created_by_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "public", default: false
      t.text "content"
      t.jsonb "metadata", default: {"@type"=>"CreativeWork", "author"=>{"name"=>"", "@type"=>"Person"}, "license"=>"", "@context"=>"https://schema.org", "description"=>""}
      t.jsonb "log_data"
      t.string "checklist_type", default: "Checklists::Single", null: false
      t.index ["created_by_id"], name: "index_library_checklists_on_created_by_id"
      t.index ["metadata"], name: "index_library_checklists_on_metadata", using: :gin
      t.index ["public"], name: "index_library_checklists_on_public"
      t.index ["status"], name: "index_library_checklists_on_status"
      t.index ["title"], name: "index_library_checklists_on_title"
    end
  end
end
