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

ActiveRecord::Schema.define(version: 2020_06_19_055022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compositions", force: :cascade do |t|
    t.string "speciesCode"
    t.float "percentage"
    t.float "meanLength"
    t.string "echogramName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "echograms", force: :cascade do |t|
    t.string "echogramName"
    t.date "recordDate"
    t.string "recordTime"
    t.float "latitude"
    t.float "longitude"
    t.integer "frequency"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hauls", force: :cascade do |t|
    t.string "echogramName"
    t.date "fishDate"
    t.string "strtFishTime"
    t.string "stpFishTime"
    t.float "strtFishLat"
    t.float "stpFishLat"
    t.float "strtFishLong"
    t.float "stpFishLong"
    t.float "strtFishDepth"
    t.float "stpFishDepth"
    t.float "bottomDepth"
    t.float "fishSpeed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species", force: :cascade do |t|
    t.string "speciesCode"
    t.string "scientificName"
    t.string "englishName"
    t.string "frenchName"
    t.string "spanishName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "password"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
