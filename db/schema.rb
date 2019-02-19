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

ActiveRecord::Schema.define(version: 2019_01_29_081646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: :cascade do |t|
    t.string "word_list"
    t.string "name", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_list"], name: "index_lists_on_word_list"
  end

  create_table "word_roots", force: :cascade do |t|
    t.string "name"
    t.string "meaning"
    t.boolean "gre_root", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gre_root"], name: "index_word_roots_on_gre_root"
    t.index ["name"], name: "index_word_roots_on_name", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "name"
    t.string "speech"
    t.string "meaning"
    t.text "sentence"
    t.jsonb "meta_data"
    t.boolean "meta_fetched", default: false
    t.boolean "frequently_occuring", default: false
    t.boolean "commonly_mistaken_words", default: false
    t.boolean "high_frequency_words", default: false
    t.string "group"
    t.boolean "parent", default: false
    t.bigint "parent_id"
    t.bigint "list_id", default: 1
    t.bigint "word_root_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "additional_info"
    t.index ["group"], name: "index_words_on_group"
    t.index ["list_id"], name: "index_words_on_list_id"
    t.index ["name"], name: "index_words_on_name", unique: true
    t.index ["parent_id"], name: "index_words_on_parent_id"
    t.index ["word_root_id"], name: "index_words_on_word_root_id"
  end

end
