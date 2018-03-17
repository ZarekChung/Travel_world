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

ActiveRecord::Schema.define(version: 20180317115811) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", force: :cascade do |t|
    t.integer "hr"
    t.string "category"
    t.text "content"
    t.string "traffic"
    t.integer "schedule_id"
    t.integer "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_details_on_schedule_id"
    t.index ["spot_id"], name: "index_details_on_spot_id"
  end

  create_table "events", force: :cascade do |t|
    t.date "start_at", null: false
    t.date "end_at", null: false
    t.string "country", null: false
    t.integer "days"
    t.string "district"
    t.text "info"
    t.integer "arg_nums"
    t.boolean "privacy"
    t.boolean "report", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.integer "last_update_user"
    t.string "photo"
    t.index ["title"], name: "index_events_on_title", unique: true
  end

  create_table "events_of_users", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "creator", default: true
    t.index ["event_id"], name: "index_events_of_users_on_event_id"
    t.index ["user_id"], name: "index_events_of_users_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_favorites_on_event_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_likes_on_event_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "comment"
    t.integer "number"
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_replies_on_event_id"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "day"
    t.string "airplane_name"
    t.string "airplane_number"
    t.string "airplane_terminal"
    t.datetime "airplane_time"
    t.string "stay"
    t.string "address"
    t.datetime "check_in"
    t.datetime "check_out"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_schedules_on_event_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "spot_name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_name"], name: "index_spots_on_spot_name", unique: true
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.string "gender"
    t.string "avatar"
    t.text "introduction"
    t.integer "point", default: 0
    t.string "role", default: "normal"
    t.string "fb_uid"
    t.string "fb_token"
    t.string "google_uid"
    t.string "google_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
