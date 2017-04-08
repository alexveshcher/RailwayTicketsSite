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

ActiveRecord::Schema.define(version: 20170408223345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "condition_groups", force: :cascade do |t|
    t.string   "condition_name"
    t.string   "type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "condition_params", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.string   "name"
    t.string   "value_type"
    t.integer  "condition_group_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["condition_group_id"], name: "index_conditions_on_condition_group_id", using: :btree
  end

  create_table "order_conditions", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "condition_id"
    t.integer  "number_value"
    t.integer  "condition_param_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["condition_param_id"], name: "index_order_conditions_on_condition_param_id", using: :btree
    t.index ["order_id", "condition_id"], name: "index_order_conditions_on_order_id_and_condition_id", unique: true, using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "from_city_id"
    t.integer  "to_city_id"
    t.date     "from_date"
    t.date     "to_date"
    t.integer  "train_id",     null: false
    t.integer  "task_id"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "conditions", "condition_groups"
  add_foreign_key "order_conditions", "condition_params"
end
