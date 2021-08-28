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

ActiveRecord::Schema.define(version: 2021_08_28_033705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "middle_name"
    t.bigint "citation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["citation_id"], name: "index_authors_on_citation_id"
    t.index ["last_name", "first_name"], name: "index_authors_on_last_name_and_first_name"
  end

  create_table "citations", force: :cascade do |t|
    t.string "origin", null: false
    t.string "content_type", null: false
    t.string "additional_contributors", array: true
    t.string "publication_title"
    t.string "publication_location"
    t.string "publisher"
    t.date "published_at"
    t.string "content_location"
    t.string "site_title"
    t.string "version"
    t.date "last_accessed_at"
    t.string "site_link"
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_citations_on_recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", null: false
    t.string "image_url"
    t.text "description"
    t.boolean "publicly_accessible", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_recipes_on_name", unique: true
  end

  create_table "step_ingredients", force: :cascade do |t|
    t.bigint "step_id", null: false
    t.bigint "ingredient_id", null: false
    t.decimal "amount", null: false
    t.string "unit"
    t.string "condition"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_step_ingredients_on_ingredient_id"
    t.index ["step_id"], name: "index_step_ingredients_on_step_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "order", null: false
    t.text "instruction", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_steps_on_recipe_id"
  end

  add_foreign_key "authors", "citations"
  add_foreign_key "citations", "recipes"
  add_foreign_key "step_ingredients", "ingredients"
  add_foreign_key "step_ingredients", "steps"
  add_foreign_key "steps", "recipes"
end
