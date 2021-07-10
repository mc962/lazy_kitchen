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

ActiveRecord::Schema.define(version: 2021_07_10_045909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_recipes_on_name", unique: true
  end

  create_table "step_ingredients", primary_key: ["step_id", "ingredient_id"], force: :cascade do |t|
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

  add_foreign_key "step_ingredients", "ingredients"
  add_foreign_key "step_ingredients", "steps"
  add_foreign_key "steps", "recipes"
end
