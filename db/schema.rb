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

ActiveRecord::Schema.define(version: 2019_06_16_145343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.integer "category_id", null: false
    t.string "category_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_categories_on_city_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "prefecture", null: false
    t.string "city"
    t.string "ward"
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.string "url", null: false
    t.integer "category", null: false
    t.string "main_title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id", "url", "main_title"], name: "index_contents_on_city_id_and_url_and_main_title", unique: true
    t.index ["city_id"], name: "index_contents_on_city_id"
  end

  create_table "municipality_infos", force: :cascade do |t|
    t.bigint "city_id"
    t.string "url", null: false
    t.integer "category", null: false
    t.date "update_time", null: false
    t.string "main_title", null: false
    t.string "sub_title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id", "url", "main_title"], name: "index_municipality_infos_on_city_id_and_url_and_main_title", unique: true
    t.index ["city_id"], name: "index_municipality_infos_on_city_id"
  end

  add_foreign_key "categories", "cities"
  add_foreign_key "contents", "cities"
  add_foreign_key "municipality_infos", "cities"
end
