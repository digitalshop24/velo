# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151229134926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bikes", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "price"
    t.integer  "year"
    t.string   "bike_class"
    t.string   "bike_type"
    t.float    "weight"
    t.text     "description"
    t.string   "frame_type"
    t.string   "handlebar"
    t.string   "chain"
    t.string   "fork"
    t.boolean  "pomp"
    t.string   "rims"
    t.string   "saddle"
    t.boolean  "roga"
    t.string   "grips"
    t.boolean  "light"
    t.string   "carriage"
    t.boolean  "basket"
    t.string   "shifters"
    t.string   "handlebar_type"
    t.boolean  "luggage_rack"
    t.boolean  "footboard"
    t.string   "tires"
    t.string   "fork_type"
    t.string   "saddle_type"
    t.string   "frame_color",           default: [],                array: true
    t.boolean  "chain_protection"
    t.string   "shifters_type"
    t.string   "pedal_type"
    t.float    "handlebar_width"
    t.float    "tires_width"
    t.boolean  "rear_fender"
    t.string   "grips_model"
    t.boolean  "double_rims"
    t.float    "wheels_diameter"
    t.string   "rear_brake"
    t.string   "rear_hub"
    t.string   "frame_material"
    t.boolean  "folding_frame"
    t.boolean  "front_fender"
    t.string   "front_hub"
    t.string   "front_brake"
    t.string   "crank_system"
    t.string   "amortization_type"
    t.string   "transmission_type"
    t.boolean  "fork_locking"
    t.string   "rims_material"
    t.string   "pedal_material"
    t.string   "absorber_length"
    t.boolean  "saddle_amortization"
    t.boolean  "horn"
    t.boolean  "rear_absorber"
    t.string   "tread"
    t.float    "fork_rod_diameter"
    t.string   "rear_brake_type"
    t.boolean  "rearview_mirror"
    t.string   "ratchet"
    t.string   "rear_derailleur"
    t.integer  "speeds_number"
    t.string   "front_break_type"
    t.string   "front_derailleur"
    t.float    "brake_disks_diameter"
    t.integer  "stars_number_cassette"
    t.integer  "stars_number_system"
    t.integer  "teeth_number_cassette"
    t.integer  "teeth_number_system"
    t.boolean  "display",               default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "hit"
  end

  add_index "bikes", ["manufacturer_id"], name: "index_bikes_on_manufacturer_id", using: :btree

  create_table "electriccars", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.integer  "price"
    t.string   "age"
    t.boolean  "remote_control"
    t.integer  "max_speed"
    t.string   "battery"
    t.string   "engine"
    t.string   "work_time"
    t.string   "charging_time"
    t.integer  "max_weight"
    t.integer  "weight"
    t.string   "sizes"
    t.string   "light"
    t.boolean  "seat_belt"
    t.boolean  "rearview_mirror"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "display"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "hit"
  end

  add_index "electriccars", ["manufacturer_id"], name: "index_electriccars_on_manufacturer_id", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.integer  "galleryable_id"
    t.string   "galleryable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "galleries", ["galleryable_type", "galleryable_id"], name: "index_galleries_on_galleryable_type_and_galleryable_id", using: :btree

  create_table "icesleds", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.string   "material"
    t.boolean  "handles"
    t.integer  "length"
    t.boolean  "display",            default: true
    t.integer  "price"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "hit"
  end

  add_index "icesleds", ["manufacturer_id"], name: "index_icesleds_on_manufacturer_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "gallery_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "images", ["gallery_id"], name: "index_images_on_gallery_id", using: :btree

  create_table "kickscooters", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "use"
    t.boolean  "electric_drive"
    t.integer  "max_weight"
    t.integer  "wheels_number"
    t.integer  "wheels_diameter"
    t.integer  "wheels_thickness"
    t.string   "wheels_material"
    t.string   "wheels_hardness"
    t.boolean  "inflatable_wheels"
    t.string   "bearings"
    t.string   "platform_material"
    t.boolean  "folding"
    t.boolean  "seat"
    t.boolean  "amortization"
    t.boolean  "front_break"
    t.boolean  "rear_break"
    t.boolean  "tilt_handle_control"
    t.boolean  "wheels_luminodiodes"
    t.integer  "min_handlebar_height"
    t.integer  "max_handlebar_height"
    t.integer  "platform_length"
    t.integer  "platform_width"
    t.integer  "length"
    t.float    "weight"
    t.boolean  "horn"
    t.boolean  "basket"
    t.boolean  "footboard"
    t.boolean  "belt"
    t.boolean  "display",              default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "hit"
  end

  add_index "kickscooters", ["manufacturer_id"], name: "index_kickscooters_on_manufacturer_id", using: :btree

  create_table "kidsbikes", force: :cascade do |t|
    t.string   "name"
    t.integer  "manufacturer_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "price"
    t.string   "recommended_age"
    t.string   "use"
    t.float    "weight"
    t.string   "seat"
    t.boolean  "seat_belts"
    t.boolean  "handle"
    t.boolean  "control_handle"
    t.boolean  "safety_rim"
    t.boolean  "visor"
    t.boolean  "music_unit"
    t.string   "frame_material"
    t.boolean  "folding_frame"
    t.string   "frame_color",          default: [],                array: true
    t.string   "fork"
    t.string   "fork_type"
    t.integer  "speeds_number"
    t.string   "rear_derailleur"
    t.string   "shifters"
    t.string   "shifters_type"
    t.string   "front_brake_type"
    t.string   "rear_brake_type"
    t.integer  "wheels_number"
    t.float    "wheels_diameter"
    t.float    "front_wheel_diameter"
    t.boolean  "attached_wheels"
    t.string   "wheels_type"
    t.boolean  "rear_wheels_stopper"
    t.boolean  "raincoat"
    t.boolean  "front_fender"
    t.boolean  "rear_fender"
    t.boolean  "chain_protection"
    t.boolean  "luggage_rack"
    t.boolean  "rearview_mirror"
    t.boolean  "horn"
    t.boolean  "basket"
    t.boolean  "bag"
    t.boolean  "flag"
    t.boolean  "footboard"
    t.boolean  "light"
    t.boolean  "pomp"
    t.boolean  "display",              default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "description"
    t.integer  "kid_height"
    t.string   "wheels_material"
    t.boolean  "sloping_backrest"
    t.boolean  "hit"
    t.string   "bike_type"
  end

  add_index "kidsbikes", ["manufacturer_id"], name: "index_kidsbikes_on_manufacturer_id", using: :btree

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skates", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.boolean  "display"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "hit"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "skates", ["manufacturer_id"], name: "index_skates_on_manufacturer_id", using: :btree

  create_table "skis", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.integer  "price"
    t.boolean  "poles"
    t.boolean  "grid"
    t.integer  "size"
    t.text     "description"
    t.boolean  "display"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "hit"
  end

  add_index "skis", ["manufacturer_id"], name: "index_skis_on_manufacturer_id", using: :btree

  create_table "sleds", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "price"
    t.text     "description"
    t.integer  "runners_width"
    t.boolean  "seat_belt"
    t.string   "seat_belt_type"
    t.boolean  "folding_visor"
    t.string   "folding_visor_type"
    t.boolean  "bag"
    t.boolean  "flicker"
    t.boolean  "backrest_adjustment"
    t.string   "color",               default: [],                array: true
    t.boolean  "transport_wheel"
    t.boolean  "legs_case"
    t.boolean  "display",             default: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "handle"
    t.string   "recommended_age"
    t.boolean  "hit"
  end

  add_index "sleds", ["manufacturer_id"], name: "index_sleds_on_manufacturer_id", using: :btree

  create_table "snowrolls", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.boolean  "display",            default: true
    t.integer  "price"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "seats_number"
    t.integer  "carrying"
    t.boolean  "hit"
  end

  add_index "snowrolls", ["manufacturer_id"], name: "index_snowrolls_on_manufacturer_id", using: :btree

  create_table "sportgoods", force: :cascade do |t|
    t.integer  "sportgoods_category_id"
    t.integer  "sportgoods_subcategory_id"
    t.integer  "manufacturer_id"
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.boolean  "display"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "hit"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "sportgoods", ["manufacturer_id"], name: "index_sportgoods_on_manufacturer_id", using: :btree
  add_index "sportgoods", ["sportgoods_category_id"], name: "index_sportgoods_on_sportgoods_category_id", using: :btree
  add_index "sportgoods", ["sportgoods_subcategory_id"], name: "index_sportgoods_on_sportgoods_subcategory_id", using: :btree

  create_table "sportgoods_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sportgoods_subcategories", force: :cascade do |t|
    t.string   "name"
    t.integer  "sportgoods_category_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tubings", force: :cascade do |t|
    t.string   "name"
    t.integer  "manufacturer_id"
    t.string   "bottom_material"
    t.string   "top_material"
    t.integer  "diameter"
    t.string   "handles_type"
    t.boolean  "tow_rope"
    t.text     "description"
    t.boolean  "display",            default: true
    t.integer  "price"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "hit"
  end

  add_index "tubings", ["manufacturer_id"], name: "index_tubings_on_manufacturer_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bikes", "manufacturers"
  add_foreign_key "electriccars", "manufacturers"
  add_foreign_key "icesleds", "manufacturers"
  add_foreign_key "images", "galleries"
  add_foreign_key "kickscooters", "manufacturers"
  add_foreign_key "kidsbikes", "manufacturers"
  add_foreign_key "skates", "manufacturers"
  add_foreign_key "skis", "manufacturers"
  add_foreign_key "sleds", "manufacturers"
  add_foreign_key "snowrolls", "manufacturers"
  add_foreign_key "sportgoods", "manufacturers"
  add_foreign_key "sportgoods", "sportgoods_categories"
  add_foreign_key "sportgoods", "sportgoods_subcategories"
  add_foreign_key "tubings", "manufacturers"
end
