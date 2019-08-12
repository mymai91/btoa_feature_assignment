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

ActiveRecord::Schema.define(version: 20190811091223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_scopes", force: :cascade do |t|
    t.bigint "role_id"
    t.string "table_name"
    t.string "field_access", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_access_scopes_on_role_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "last_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "email", default: "", null: false
    t.integer "gender", limit: 2, default: 0, null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "role_id"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["role_id"], name: "index_employees_on_role_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "currency"
    t.bigint "base_salary"
    t.bigint "overtime_payment"
    t.bigint "bonus"
    t.bigint "transport"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_incomes_on_employee_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_permissions", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  add_foreign_key "access_scopes", "roles"
  add_foreign_key "employees", "roles"
  add_foreign_key "incomes", "employees"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
end
