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

ActiveRecord::Schema.define(version: 20150521051918) do

  create_table "authors", force: :cascade do |t|
    t.text     "name",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "categories", ["content"], name: "index_categories_on_content", unique: true, using: :btree

  create_table "categorizations", force: :cascade do |t|
    t.integer  "quote_id",    limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree
  add_index "categorizations", ["quote_id"], name: "index_categorizations_on_quote_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "quote_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["quote_id"], name: "index_comments_on_quote_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "favorite_quotes", force: :cascade do |t|
    t.integer  "quote_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "favorite_quotes", ["quote_id"], name: "index_favorite_quotes_on_quote_id", using: :btree
  add_index "favorite_quotes", ["user_id"], name: "index_favorite_quotes_on_user_id", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.text     "content",      limit: 65535
    t.integer  "author_id",    limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "content_hash", limit: 255
    t.text     "extra",        limit: 65535
  end

  add_index "quotes", ["author_id", "content_hash"], name: "index_quotes_on_author_id_and_content_hash", unique: true, using: :btree
  add_index "quotes", ["author_id"], name: "index_quotes_on_author_id", using: :btree
  add_index "quotes", ["content_hash"], name: "index_quotes_on_content_hash", using: :btree
  add_index "quotes", ["user_id"], name: "index_quotes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "oauth_token",            limit: 255
    t.string   "oauth_secret",           limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "value",      limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "quote_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "votes", ["quote_id", "user_id"], name: "index_votes_on_quote_id_and_user_id", unique: true, using: :btree
  add_index "votes", ["quote_id"], name: "index_votes_on_quote_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "categorizations", "categories"
  add_foreign_key "categorizations", "quotes"
  add_foreign_key "comments", "quotes"
  add_foreign_key "comments", "users"
  add_foreign_key "favorite_quotes", "quotes"
  add_foreign_key "favorite_quotes", "users"
  add_foreign_key "quotes", "authors"
  add_foreign_key "quotes", "users"
  add_foreign_key "votes", "quotes"
  add_foreign_key "votes", "users"
end
