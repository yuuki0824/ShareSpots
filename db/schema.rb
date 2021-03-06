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

ActiveRecord::Schema.define(version: 20170126104827) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "spots_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "spot_id"
    t.string   "body"
  end

  add_index "comments", ["spot_id"], name: "index_comments_on_spot_id"
  add_index "comments", ["spots_id"], name: "index_comments_on_spots_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["spot_id"], name: "index_likes_on_spot_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "age"
    t.string   "birthplace"
    t.string   "self_introducation"
    t.date     "birthday"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "spots", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "date"
    t.string   "address"
    t.string   "description"
    t.decimal  "latitude",    precision: 9,  scale: 6
    t.decimal  "longitude",   precision: 10, scale: 6
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "image"
  end

  add_index "spots", ["user_id", "created_at"], name: "index_spots_on_user_id_and_created_at"
  add_index "spots", ["user_id"], name: "index_spots_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
