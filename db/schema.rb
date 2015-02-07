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

ActiveRecord::Schema.define(version: 20150205143731) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "uid"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "twilio_call_id"
  end

  create_table "breakup_types", force: :cascade do |t|
    t.boolean  "sad"
    t.boolean  "obnoxious"
    t.boolean  "funny"
    t.boolean  "weird"
    t.string   "other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recordings", force: :cascade do |t|
    t.string   "url"
    t.string   "length"
    t.string   "transcript"
    t.integer  "twilio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "story_id"
    t.string   "sid"
  end

  create_table "stories", force: :cascade do |t|
    t.integer  "recording_id"
    t.string   "name"
    t.string   "person"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "age"
    t.string   "location"
    t.boolean  "was_checked",           default: false
    t.integer  "account_id"
    t.integer  "selected_recording_id"
    t.string   "gender"
    t.string   "contact"
    t.string   "breakup_role"
    t.text     "notes"
    t.string   "pullquote"
  end

  create_table "twilio_calls", force: :cascade do |t|
    t.string   "sid"
    t.string   "from"
    t.string   "fromCity"
    t.string   "fromState"
    t.string   "fromZip"
    t.string   "fromCountry"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "unique_ids", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
