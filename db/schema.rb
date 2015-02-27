# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150227212343) do

  create_table "recordings", force: :cascade do |t|
    t.integer  "story_id"
    t.string   "url"
    t.string   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "recordings", ["story_id", "created_at"], name: "index_recordings_on_story_id_and_created_at"
  add_index "recordings", ["story_id"], name: "index_recordings_on_story_id"

  create_table "stories", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.integer  "age"
    t.string   "location"
    t.integer  "selected_recording_id"
    t.string   "breakup_role"
    t.text     "pullquote"
    t.string   "breakup_type"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "start_dating"
    t.date     "end_dating"
  end

  add_index "stories", ["user_id", "created_at"], name: "index_stories_on_user_id_and_created_at"
  add_index "stories", ["user_id"], name: "index_stories_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "phone_number",            default: "",    null: false
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "phone_verification_code", default: "",    null: false
    t.boolean  "phone_verified",          default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["phone_number"], name: "index_users_on_phone", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
