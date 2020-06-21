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

ActiveRecord::Schema.define(version: 2020_06_21_000509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compositions", force: :cascade do |t|
    t.string "species_code"
    t.float "percentage"
    t.float "mean_length"
    t.string "echogram_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "echograms", force: :cascade do |t|
    t.string "echogram_name"
    t.date "record_date"
    t.string "record_time"
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

  create_table "species", force: :cascade do |t|
    t.string "species_code"
    t.string "scientific_name"
    t.string "english_name"
    t.string "french_name"
    t.string "spanish_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "password"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
