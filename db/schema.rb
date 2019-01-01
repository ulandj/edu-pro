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

ActiveRecord::Schema.define(version: 2019_01_01_090832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "adminpack"
  enable_extension "plpgsql"

  create_table "channel_settings", force: :cascade do |t|
    t.bigint "channel_id"
    t.string "primary_location_id", null: false
    t.boolean "multi_location_enabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "synced", default: false
    t.index ["channel_id"], name: "index_channel_settings_on_channel_id"
  end

  create_table "channels", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.boolean "active", default: false, null: false
    t.string "url"
    t.string "shopify_url"
    t.string "shopify_access_token"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "products_successfully_fetched_at"
    t.datetime "products_successfully_pulled_at"
    t.index ["products_successfully_fetched_at"], name: "index_channels_on_products_successfully_fetched_at"
    t.index ["products_successfully_pulled_at"], name: "index_channels_on_products_successfully_pulled_at"
    t.index ["token"], name: "index_channels_on_token", unique: true
    t.index ["user_id"], name: "index_channels_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "channel_id"
    t.string "remote_id", null: false
    t.string "title"
    t.jsonb "variants", default: [], null: false
    t.jsonb "options", default: [], null: false
    t.jsonb "images", default: [], null: false
    t.datetime "remote_created_at"
    t.datetime "remote_updated_at"
    t.datetime "remote_published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "synced", default: false
    t.index ["channel_id", "remote_id"], name: "index_products_on_channel_id_and_remote_id", unique: true
    t.index ["channel_id"], name: "index_products_on_channel_id"
    t.index ["images"], name: "index_products_on_images", using: :gin
    t.index ["options"], name: "index_products_on_options", using: :gin
    t.index ["variants"], name: "index_products_on_variants", using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "channel_settings", "channels"
  add_foreign_key "channels", "users"
  add_foreign_key "products", "channels", on_delete: :cascade
end
