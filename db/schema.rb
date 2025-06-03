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

ActiveRecord::Schema[8.0].define(version: 2025_05_30_210129) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historicos", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "quantity_change"
    t.string "action_type"
    t.string "user"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_historicos_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
    t.text "description"
    t.boolean "buy", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.integer "category_id", null: false
    t.integer "quantity"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "stock_activities", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "quantity_change"
    t.string "action_type"
    t.integer "user_id", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stock_activities_on_product_id"
    t.index ["user_id"], name: "index_stock_activities_on_user_id"
  end

  create_table "stock_historicals", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "quantity_change"
    t.string "action_type"
    t.string "user"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stock_historicals_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "historicos", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "stock_activities", "products"
  add_foreign_key "stock_activities", "users"
  add_foreign_key "stock_historicals", "products"
end
