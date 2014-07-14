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

ActiveRecord::Schema.define(version: 20140713235741) do

  create_table "band_members", force: true do |t|
    t.string   "band_id"
    t.string   "name"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bands", force: true do |t|
    t.integer  "user_id"
    t.integer  "band_id"
    t.integer  "track_count"
    t.integer  "total_votes"
    t.string   "username"
    t.string   "permalink_url"
    t.string   "avatar_url"
    t.string   "country"
    t.string   "full_name"
    t.string   "city"
    t.string   "website"
    t.string   "website_title"
    t.string   "band_members"
    t.string   "class_years"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "parent_id"
    t.integer  "comment_id"
    t.string   "create_at"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descriptions", force: true do |t|
    t.integer  "band_id"
    t.integer  "user_id"
    t.string   "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discriptions", force: true do |t|
    t.integer  "user_id"
    t.string   "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "banner_color"
    t.string   "background_color"
    t.integer  "total_votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", force: true do |t|
    t.integer  "votes"
    t.integer  "track_id"
    t.integer  "band_id"
    t.integer  "duration"
    t.integer  "bpm"
    t.integer  "comment_count"
    t.integer  "playback_count"
    t.string   "track_created_at"
    t.string   "title"
    t.string   "permalink_url"
    t.string   "artwork_url"
    t.string   "description"
    t.string   "genre"
    t.string   "release"
    t.string   "release_day"
    t.string   "release_month"
    t.string   "release_year"
    t.string   "waveform_url"
    t.string   "stream_url"
    t.string   "key_signature"
    t.boolean  "streamable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "soundcloud_username"
    t.string   "soundcloud_access_token"
    t.string   "soundcloud_refresh_token"
    t.string   "hometown"
    t.boolean  "admin",                    default: false
    t.integer  "soundcloud_user_id"
    t.integer  "school_id"
    t.datetime "soundcloud_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "votes", force: true do |t|
    t.integer  "track_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["ip"], name: "index_votes_on_ip"
  add_index "votes", ["track_id"], name: "index_votes_on_track_id"

end
