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

ActiveRecord::Schema.define(version: 2020_07_01_101130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compositions", force: :cascade do |t|
    t.string "species_code"
    t.float "percentage"
    t.float "mean_length"
    t.string "echogram_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "n_individuals"
  end

  create_table "echograms", primary_key: "echogram_name", id: :string, force: :cascade do |t|
    t.bigserial "id", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "frequency"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hauls", force: :cascade do |t|
    t.string "echogram_name"
    t.date "fish_date"
    t.string "strt_fish_time"
    t.string "stp_fish_time"
    t.float "strt_fish_lat"
    t.float "stp_fish_lat"
    t.float "strt_fish_long"
    t.float "stp_fish_long"
    t.float "strt_fish_depth"
    t.float "stp_fish_depth"
    t.float "bottom_depth"
    t.float "fish_speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species", primary_key: "species_code", id: :string, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "scientific_name"
    t.string "english_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_filename"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "phone"
    t.string "password"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "compositions", "echograms", column: "echogram_name", primary_key: "echogram_name", name: "fky2"
  add_foreign_key "compositions", "species", column: "species_code", primary_key: "species_code", name: "fkey1"
  add_foreign_key "echograms", "users", name: "echograms_fkey"
  add_foreign_key "hauls", "echograms", column: "echogram_name", primary_key: "echogram_name", name: "hauls_fkey"
end
