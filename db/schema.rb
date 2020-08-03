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

ActiveRecord::Schema.define(version: 2020_08_01_193935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "composition_temps", force: :cascade do |t|
    t.string "echogram_name"
    t.string "species"
    t.string "numbers"
    t.float "percentage"
    t.string "mean_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "compositions", force: :cascade do |t|
    t.string "species_code"
    t.float "percentage"
    t.float "mean_length"
    t.string "echogram_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "n_individuals"
  end

  create_table "echogram_temps", force: :cascade do |t|
    t.string "echogram_name"
    t.string "image_filename"
    t.integer "frequency"
    t.integer "haul_id"
    t.integer "user_id"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "editable"
  end

  create_table "echograms", force: :cascade do |t|
    t.string "echogram_name", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "frequency"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "haul_id"
    t.string "image_filename"
  end

  create_table "haul_temps", force: :cascade do |t|
    t.string "echogram_name"
    t.string "strt_fish_time"
    t.string "stp_fish_time"
    t.date "fish_date"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "compositions", "species", column: "species_code", primary_key: "species_code", name: "compositions_fkey"
  add_foreign_key "echogram_temps", "users", name: "echogram_temps_fkey1"
  add_foreign_key "echograms", "users", name: "echograms_fkey"

  create_view "my_compositions", sql_definition: <<-SQL
      SELECT compositions.echogram_name AS gramname,
      species.scientific_name AS sciname,
      species.english_name AS engname,
      species.species_code AS scode,
      compositions.percentage AS percent,
      compositions.mean_length AS avglength,
      compositions.n_individuals AS num
     FROM (compositions
       JOIN species ON (((compositions.species_code)::text = (species.species_code)::text)))
    ORDER BY compositions.echogram_name;
  SQL
  create_view "my_grams", sql_definition: <<-SQL
      SELECT echograms.echogram_name AS gramname,
      echograms.latitude AS lat,
      echograms.longitude AS long,
      hauls.fish_date AS date,
      echograms.frequency,
      echograms.image_filename AS image
     FROM (echograms
       JOIN hauls ON ((echograms.haul_id = hauls.id)))
    ORDER BY echograms.echogram_name;
  SQL
end
