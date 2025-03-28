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

ActiveRecord::Schema[7.0].define(version: 2023_01_12_084738) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "academic_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.integer "user_id"
    t.text "question"
    t.text "answer"
    t.boolean "published", default: false
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "slug"
    t.integer "content_type"
    t.string "source"
    t.boolean "notified", default: false
    t.index ["slug"], name: "index_contents_on_slug", unique: true
  end

  create_table "crono_jobs", force: :cascade do |t|
    t.string "job_id", null: false
    t.text "log"
    t.datetime "last_performed_at", precision: nil
    t.boolean "healthy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_crono_jobs_on_job_id", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at", precision: nil
    t.datetime "locked_at", precision: nil
    t.datetime "failed_at", precision: nil
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "english_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at", precision: nil
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "indicators", force: :cascade do |t|
    t.integer "signal_id", null: false
    t.integer "user_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id", default: 0
    t.string "message"
    t.integer "category"
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_qualities", force: :cascade do |t|
    t.string "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_urgencies", force: :cascade do |t|
    t.integer "urgency"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "topic"
    t.text "instructions"
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_status_id"
    t.integer "order_type_id"
    t.string "code"
    t.boolean "paid", default: false
    t.string "token"
    t.float "price"
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
    t.datetime "paid_on", precision: nil
    t.datetime "completed_on", precision: nil
    t.integer "subject_id"
    t.datetime "due_date", precision: nil
    t.float "discount", default: 0.0
    t.integer "content_id"
  end

  create_table "paper_formats", force: :cascade do |t|
    t.string "name"
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "read_messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_read_messages_on_message_id"
    t.index ["user_id"], name: "index_read_messages_on_user_id"
  end

  create_table "resource_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.integer "order_id"
    t.integer "resource_type_id", default: 1
    t.string "name"
    t.string "internal_resource_url"
    t.string "description"
    t.string "file"
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "order_id"
    t.integer "stars"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_settings", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_vouchers", force: :cascade do |t|
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.integer "user_id"
    t.integer "voucher_id"
    t.integer "order_id"
    t.string "voucher_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "key", default: -> { "uuid_generate_v4()" }
    t.boolean "admin", default: false
  end

  create_table "vouchers", force: :cascade do |t|
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
