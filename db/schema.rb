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

ActiveRecord::Schema.define(version: 20150325095902) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.integer  "group_id"
    t.integer  "user_id"
    t.string   "date"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "images", force: true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.string   "content_type"
    t.binary   "data",         limit: 1048576
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "pictures", force: true do |t|
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
  end

  add_index "pictures", ["article_id", "created_at"], name: "index_pictures_on_article_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "family"
    t.string   "given"
    t.string   "maiden"
    t.string   "pobox"
    t.string   "region"
    t.string   "city"
    t.string   "street"
    t.string   "tel"
    t.string   "mobile"
    t.string   "notes"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
    t.integer  "group_id"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
