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

ActiveRecord::Schema.define(version: 20180103124035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string "provider"
    t.string "username"
    t.string "uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "teacher_id"
    t.boolean "teacher_approved", default: false, null: false
    t.boolean "fee_paid", default: false, null: false
    t.string "location"
    t.string "custom_location"
    t.text "notes"
    t.datetime "requested_start"
    t.datetime "requested_finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "legacy_teacher"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres_users", id: false, force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "howdidfinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.string "image_content_type"
    t.integer "image_size"
    t.integer "image_width"
    t.integer "image_height"
    t.string "item_type"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_images_on_item_type_and_item_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "user_id"
    t.date "due_date"
    t.string "description"
    t.boolean "is_paid"
    t.string "pdf"
    t.string "pdf_content_type"
    t.float "amount"
    t.integer "pdf_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "language_id", null: false
  end

  create_table "legacyteachers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "nfcs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "tag_address"
    t.boolean "active"
    t.datetime "last_used"
    t.boolean "collected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_nfcs_on_user_id"
  end

  create_table "regularavailabilities", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "day_of_week"
    t.time "open_time"
    t.time "close_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_regularavailabilities_on_user_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "specialavailabilities", force: :cascade do |t|
    t.bigint "user_id"
    t.date "date"
    t.time "open_time"
    t.time "close_time"
    t.boolean "is_available"
    t.date "recur_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_specialavailabilities_on_user_id"
  end

  create_table "teachinglevels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachinglevels_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "teachinglevel_id", null: false
  end

  create_table "teachinglocations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachinglocations_users", id: false, force: :cascade do |t|
    t.bigint "teachinglocation_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username"
    t.string "main_instrument"
    t.string "other_instrument"
    t.string "slug"
    t.string "address"
    t.integer "in_helsinki"
    t.string "city"
    t.date "birthdate"
    t.string "parental_name"
    t.string "website"
    t.string "facebook"
    t.string "twitter"
    t.string "other_links"
    t.string "avatar"
    t.string "avatar_content_type"
    t.bigint "avatar_size"
    t.integer "avatar_width"
    t.integer "avatar_height"
    t.string "publications"
    t.text "summary"
    t.integer "hourly_rate"
    t.string "custom_hourly_rate"
    t.bigint "availability_id"
    t.integer "experienced"
    t.integer "has_own_instrument"
    t.integer "desired_lessons"
    t.integer "lesson_time"
    t.bigint "howdidfind_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "applied_as_teacher"
    t.boolean "applied_as_student"
    t.boolean "approved_teacher"
    t.boolean "approved_student"
    t.string "cv"
    t.string "cv_content_type"
    t.bigint "cv_size"
    t.string "other_languages"
    t.string "custom_teaching_level"
    t.string "custom_hours"
    t.string "custom_teachinglocation"
    t.string "custom_howdidfind"
    t.string "custom_experience"
    t.string "custom_hasinstrument"
    t.string "custom_havelessons"
    t.string "custom_lessontime"
    t.string "custom_instrumentgenre"
    t.string "custom_teacher"
    t.string "further_comments"
    t.string "voucher"
    t.string "specific_teacher"
    t.string "desired_teacher"
    t.boolean "legacy_student"
    t.index ["availability_id"], name: "index_users_on_availability_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["howdidfind_id"], name: "index_users_on_howdidfind_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "bookings", "users"
  add_foreign_key "invoices", "users"
  add_foreign_key "nfcs", "users"
  add_foreign_key "regularavailabilities", "users"
  add_foreign_key "specialavailabilities", "users"
end
