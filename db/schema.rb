# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_04_212120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "academic_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "english_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_qualities", force: :cascade do |t|
    t.string "quality"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_urgencies", force: :cascade do |t|
    t.integer "urgency"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "topic"
    t.text "instructions"
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "order_status_id"
    t.integer "order_type_id"
    t.string "code"
    t.boolean "paid", default: false
    t.string "token"
    t.integer "price"
    t.integer "pages"
    t.integer "order_quality_id"
    t.integer "order_urgency_id"
    t.integer "sources_count", default: 0
    t.integer "charts_count", default: 0
    t.integer "slides_count", default: 0
    t.integer "spacing", default: 1
    t.integer "paper_format_id", default: 1
    t.integer "english_type_id", default: 1
    t.integer "academic_level_id", default: 1
  end

  create_table "paper_formats", force: :cascade do |t|
    t.string "name"
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resource_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resources", force: :cascade do |t|
    t.integer "order_id"
    t.integer "resource_type_id", default: 1
    t.string "name"
    t.string "internal_resource_url"
    t.string "description"
    t.string "file"
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.boolean "enabled", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.boolean "admin", default: false
  end

end
