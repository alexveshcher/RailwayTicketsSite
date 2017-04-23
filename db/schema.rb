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

ActiveRecord::Schema.define(version: 20170423162323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "condition_groups", force: :cascade do |t|
    t.string   "condition_name"
    t.string   "condition_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "handler_name"
  end

  create_table "condition_params", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "condition_id"
    t.index ["condition_id"], name: "index_condition_params_on_condition_id", using: :btree
  end

  create_table "conditions", force: :cascade do |t|
    t.string   "name"
    t.string   "value_type"
    t.integer  "condition_group_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "sysname"
    t.index ["condition_group_id"], name: "index_conditions_on_condition_group_id", using: :btree
    t.index ["name"], name: "index_conditions_on_name", unique: true, using: :btree
  end

  create_table "cycles", force: :cascade do |t|
    t.integer  "execution_time"
    t.string   "error_message"
    t.string   "service_message"
    t.boolean  "success"
    t.integer  "task_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "order_conditions", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "condition_id"
    t.integer  "number_value"
    t.integer  "condition_param_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "string_value"
    t.index ["condition_param_id"], name: "index_order_conditions_on_condition_param_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "from_city_id"
    t.integer  "to_city_id"
    t.date     "from_date"
    t.date     "to_date"
    t.integer  "task_id"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.string   "from_city_name"
    t.string   "to_city_name"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "task_string_id"
    t.integer  "fails_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "condition_params", "conditions"
  add_foreign_key "conditions", "condition_groups"
  add_foreign_key "cycles", "tasks"
  add_foreign_key "order_conditions", "condition_params"
  add_foreign_key "order_conditions", "conditions"
  add_foreign_key "order_conditions", "orders"
  add_foreign_key "orders", "tasks"
  add_foreign_key "orders", "users"
end
