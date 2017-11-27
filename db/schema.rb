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

ActiveRecord::Schema.define(version: 20171127132309) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "unconfirmed_email"
    t.boolean  "admin",                  default: true
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "card_transactions", force: :cascade do |t|
    t.integer  "card_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "card_transactions", ["card_id"], name: "index_card_transactions_on_card_id"

  create_table "cards", force: :cascade do |t|
    t.integer  "registration_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "cards", ["registration_id"], name: "index_cards_on_registration_id"

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_details", force: :cascade do |t|
    t.string   "model_number"
    t.string   "model_description"
    t.string   "product_detail_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "product_id"
  end

  add_index "product_details", ["product_id"], name: "index_product_details_on_product_id"

  create_table "products", force: :cascade do |t|
    t.string   "product_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.decimal  "price"
  end

  create_table "questionaires", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "quote_id"
    t.string   "product_type"
    t.text     "comments"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "questionaires", ["quote_id"], name: "index_questionaires_on_quote_id"
  add_index "questionaires", ["user_id"], name: "index_questionaires_on_user_id"

  create_table "quote_details", force: :cascade do |t|
    t.integer  "quote_id"
    t.text     "quote_comments"
    t.string   "approved_by"
    t.string   "rejected_by"
    t.text     "rejected_reason"
    t.decimal  "estimate"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.string   "quote_type"
    t.integer  "user_id"
    t.boolean  "approved"
    t.boolean  "pending"
    t.boolean  "rejected"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "product_id"
    t.integer  "requester_type_id"
  end

  add_index "quotes", ["product_id"], name: "index_quotes_on_product_id"
  add_index "quotes", ["requester_type_id"], name: "index_quotes_on_requester_type_id"

  create_table "registrations", force: :cascade do |t|
    t.string   "full_name"
    t.string   "company"
    t.string   "email"
    t.string   "telephone"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "notification_params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "purchased_at"
    t.integer  "product_id"
  end

  add_index "registrations", ["product_id"], name: "index_registrations_on_product_id"

  create_table "requester_types", force: :cascade do |t|
    t.string   "requester_type_name"
    t.string   "requester_type_code"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer  "quote_id"
    t.decimal  "total"
    t.decimal  "tax"
    t.decimal  "labor"
    t.decimal  "parts_cost"
    t.datetime "date_sold"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "unconfirmed_email"
    t.boolean  "approved",               default: false, null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "affiliation"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["approved"], name: "index_users_on_approved"
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
