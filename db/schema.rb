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

ActiveRecord::Schema[7.0].define(version: 2023_06_12_121205) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "incidents", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "location"
    t.boolean "is_closed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "incident_type"
    t.integer "review_rating"
    t.string "review_text"
    t.index ["user_id"], name: "index_incidents_on_user_id"
  end

  create_table "medical_infos", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responders", force: :cascade do |t|
    t.bigint "incident_id", null: false
    t.bigint "user_id", null: false
    t.string "location"
    t.boolean "has_accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_arrived", default: false
    t.index ["incident_id"], name: "index_responders_on_incident_id"
    t.index ["user_id"], name: "index_responders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.bigint "medical_info_id"
    t.string "languages"
    t.string "height"
    t.string "medication"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["medical_info_id"], name: "index_users_on_medical_info_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "incidents", "users"
  add_foreign_key "responders", "incidents"
  add_foreign_key "responders", "users"
  add_foreign_key "users", "medical_infos"
end
