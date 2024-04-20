# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_20_004225) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "action_markdown_markdown_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_markdown_markdown_texts_uniqueness", unique: true
  end

  create_table "checklist_instances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "checklist_id", null: false
    t.string "assignee_type"
    t.uuid "assignee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_type", "assignee_id"], name: "index_checklist_instances_on_assignee"
    t.index ["checklist_id"], name: "index_checklist_instances_on_checklist_id"
  end

  create_table "checklists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type", null: false
    t.string "title"
    t.string "status"
    t.uuid "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "assignee_type"
    t.uuid "assignee_id"
    t.string "instance_model", default: "single", null: false
    t.index ["assignee_type", "assignee_id"], name: "index_checklists_on_assignee"
    t.index ["created_by_id"], name: "index_checklists_on_created_by_id"
    t.index ["status"], name: "index_checklists_on_status"
    t.index ["title"], name: "index_checklists_on_title"
    t.index ["type"], name: "index_checklists_on_type"
  end

  create_table "templates_checklists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "status", default: "draft"
    t.uuid "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contributor"
    t.string "creator"
    t.string "description"
    t.string "format", default: "text/markdown"
    t.string "language", default: "en"
    t.string "publisher"
    t.string "rights"
    t.string "source"
    t.string "title_alternative"
    t.index ["created_by_id"], name: "index_templates_checklists_on_created_by_id"
    t.index ["status"], name: "index_templates_checklists_on_status"
    t.index ["title"], name: "index_templates_checklists_on_title"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "checklist_instances", "checklists"
  add_foreign_key "checklists", "users", column: "created_by_id"
  add_foreign_key "templates_checklists", "users", column: "created_by_id"
end
