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

ActiveRecord::Schema.define(version: 20171208092947) do

  create_table "events", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "user_reference"
    t.string   "channel"
    t.text     "event_text"
    t.string   "type_label"
    t.string   "subtype_label"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "team_id"
    t.string   "user_access_token"
    t.string   "bot_user_id"
    t.string   "bot_access_token"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
