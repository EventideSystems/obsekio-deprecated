class DropActionMarkdownMarkdownTextsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table "action_markdown_markdown_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "name", null: false
      t.text "body"
      t.string "record_type", null: false
      t.uuid "record_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["record_type", "record_id", "name"], name: "index_action_markdown_markdown_texts_uniqueness", unique: true
    end
  end
end
