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

ActiveRecord::Schema.define(version: 20160229225222) do

  create_table "agents", force: :cascade do |t|
    t.decimal  "comission",              precision: 4, scale: 2
    t.string   "phone",      limit: 255
    t.string   "mobile",     limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "agents", ["user_id"], name: "index_agents_on_user_id", using: :btree

  create_table "customer_properties", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.integer  "property_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "favorite"
  end

  add_index "customer_properties", ["customer_id"], name: "index_customer_properties_on_customer_id", using: :btree
  add_index "customer_properties", ["property_id"], name: "index_customer_properties_on_property_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.integer  "title",      limit: 4
    t.string   "phone",      limit: 255
    t.string   "mobile",     limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "customers", ["user_id"], name: "index_customers_on_user_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "description",   limit: 65535
    t.text     "photo",         limit: 65535
    t.decimal  "price",                       precision: 12, scale: 2
    t.string   "street_number", limit: 255
    t.string   "street_name",   limit: 255
    t.string   "suite",         limit: 255
    t.string   "zipcode",       limit: 255
    t.string   "city",          limit: 255
    t.integer  "state_id",      limit: 4
    t.integer  "agent_id",      limit: 4
    t.integer  "status",        limit: 4
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "properties", ["agent_id"], name: "index_properties_on_agent_id", using: :btree
  add_index "properties", ["state_id"], name: "index_properties_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.integer  "role",            limit: 4
    t.integer  "status",          limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "agents", "users"
  add_foreign_key "customer_properties", "customers"
  add_foreign_key "customer_properties", "properties"
  add_foreign_key "customers", "users"
  add_foreign_key "properties", "agents"
  add_foreign_key "properties", "states"
end
