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

ActiveRecord::Schema.define(version: 20140501025538) do

  create_table "group_invites", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.integer  "admin_id"
    t.string   "name"
    t.string   "tagline"
    t.string   "gender"
    t.string   "seeking_gender"
    t.integer  "location_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["gender"], name: "index_groups_on_gender", using: :btree
  add_index "groups", ["location_id"], name: "index_groups_on_location_id", using: :btree
  add_index "groups", ["seeking_gender"], name: "index_groups_on_seeking_gender", using: :btree

  create_table "groups_interests", force: true do |t|
    t.integer "group_id"
    t.integer "interest_id"
  end

  create_table "groups_users", force: true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "interests", force: true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string "city"
    t.string "country"
  end

  add_index "locations", ["city"], name: "index_locations_on_city", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "liker_id"
    t.integer  "liked_id"
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["like"], name: "index_relationships_on_like", using: :btree
  add_index "relationships", ["liked_id"], name: "index_relationships_on_liked_id", using: :btree
  add_index "relationships", ["liker_id", "liked_id"], name: "index_relationships_on_liker_id_and_liked_id", unique: true, using: :btree
  add_index "relationships", ["liker_id"], name: "index_relationships_on_liker_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "gender"
    t.string   "birthday"
    t.string   "location"
    t.string   "profile_picture"
    t.boolean  "available"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
