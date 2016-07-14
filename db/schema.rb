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

ActiveRecord::Schema.define(version: 20160714085930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.integer  "city_id"
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "default"
    t.integer  "shop_id"
    t.datetime "deleted_at"
    t.index ["city_id"], name: "index_addresses_on_city_id", using: :btree
    t.index ["deleted_at"], name: "index_addresses_on_deleted_at", using: :btree
    t.index ["shop_id"], name: "index_addresses_on_shop_id", using: :btree
    t.index ["user_id"], name: "index_addresses_on_user_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["remember_token"], name: "index_admin_users_on_remember_token", using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "bonuses", force: :cascade do |t|
    t.integer  "bonus_type", null: false
    t.integer  "user_id",    null: false
    t.integer  "order_id",   null: false
    t.integer  "amount",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bonus_type"], name: "index_bonuses_on_bonus_type", using: :btree
    t.index ["order_id"], name: "index_bonuses_on_order_id", using: :btree
    t.index ["user_id"], name: "index_bonuses_on_user_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.integer  "salesman_id"
    t.integer  "shop_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["salesman_id"], name: "index_connections_on_salesman_id", using: :btree
    t.index ["shop_id"], name: "index_connections_on_shop_id", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.string   "slug",                    null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["slug"], name: "index_countries_on_slug", unique: true, using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.decimal  "discount"
    t.boolean  "active"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "target",     default: 0
    t.index ["code"], name: "index_coupons_on_code", unique: true, using: :btree
  end

  create_table "filters", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "order_products", force: :cascade do |t|
    t.integer  "order_id"
    t.decimal  "quantity",                    precision: 5, scale: 1,              null: false
    t.integer  "product_id"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.string   "comment",                                             default: "", null: false
    t.decimal  "actual_quantity"
    t.decimal  "actual_price"
    t.decimal  "product_price_cache"
    t.integer  "product_step_cache"
    t.integer  "product_quantity_type_cache"
    t.index ["order_id"], name: "index_order_products_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_products_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "status",               default: 0,  null: false
    t.string   "address",              default: "", null: false
    t.string   "comment",              default: "", null: false
    t.date     "date"
    t.float    "latitude"
    t.float    "longitude"
    t.time     "time_start"
    t.time     "time_end"
    t.integer  "row_order",            default: 0
    t.integer  "coupon_id"
    t.integer  "retailcrm_id"
    t.datetime "deleted_at"
    t.integer  "nearby_orders_cache",  default: 0
    t.decimal  "delivery_cost"
    t.decimal  "gross_profit_cache"
    t.decimal  "gross_margin_cache"
    t.decimal  "expenses"
    t.integer  "address_id"
    t.decimal  "actual_delivery_cost"
    t.integer  "order_type",           default: 0
    t.integer  "cash"
    t.index ["address_id"], name: "index_orders_on_address_id", using: :btree
    t.index ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.tsvector "content_tsvector"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["content_tsvector"], name: "index_pg_search_documents_on_content_tsvector", using: :gist
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "banner"
    t.string   "image"
    t.string   "description"
    t.string   "extended_description"
    t.integer  "position"
    t.index ["slug"], name: "index_product_categories_on_slug", unique: true, using: :btree
  end

  create_table "product_filters", force: :cascade do |t|
    t.integer  "filter_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filter_id"], name: "index_product_filters_on_filter_id", using: :btree
    t.index ["product_id"], name: "index_product_filters_on_product_id", using: :btree
  end

  create_table "product_relationships", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "related_product_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["product_id", "related_product_id"], name: "product_relationships_unique", unique: true, using: :btree
    t.index ["product_id"], name: "index_product_relationships_on_product_id", using: :btree
    t.index ["related_product_id"], name: "index_product_relationships_on_related_product_id", using: :btree
  end

  create_table "product_subcategories", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_product_subcategories_on_category_id", using: :btree
    t.index ["slug"], name: "index_product_subcategories_on_slug", unique: true, using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",                                  default: "",    null: false
    t.integer  "country_id"
    t.string   "photo",                                                  null: false
    t.integer  "quantity_type",                          default: 0,     null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.decimal  "price",          precision: 8, scale: 2, default: "0.0", null: false
    t.boolean  "featured",                               default: false, null: false
    t.integer  "subcategory_id"
    t.integer  "step",                                   default: 1,     null: false
    t.boolean  "disabled",                               default: false, null: false
    t.integer  "discount"
    t.boolean  "new",                                    default: false, null: false
    t.integer  "quantity_max",                           default: 5
    t.text     "description"
    t.index ["country_id"], name: "index_products_on_country_id", using: :btree
    t.index ["subcategory_id"], name: "index_products_on_subcategory_id", using: :btree
  end

  create_table "schedule_days", force: :cascade do |t|
    t.date     "date"
    t.boolean  "template"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_schedule_days_on_date", using: :btree
  end

  create_table "schedule_intervals", force: :cascade do |t|
    t.integer  "schedule_day_id"
    t.time     "time_start"
    t.time     "time_end"
    t.integer  "day_part"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["schedule_day_id"], name: "index_schedule_intervals_on_schedule_day_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "type"
    t.text     "properties"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "shop_categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "title"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "owner_name"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "shop_category_id"
    t.index ["shop_category_id"], name: "index_shops_on_shop_category_id", using: :btree
    t.index ["user_id"], name: "index_shops_on_user_id", using: :btree
  end

  create_table "user_authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider", "uid"], name: "index_user_authentications_on_provider_and_uid", using: :btree
  end

  create_table "user_cards", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer  "user_id"
    t.string   "card_first_six"
    t.string   "card_last_four"
    t.string   "card_type"
    t.string   "issuer_bank_country"
    t.string   "token"
    t.string   "card_exp_date"
    t.boolean  "active"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_user_cards_on_user_id", using: :btree
  end

  create_table "user_favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "favoriteable_id"
    t.string  "favoriteable_type"
    t.index ["favoriteable_type", "favoriteable_id"], name: "index_user_favorites_on_favoriteable_type_and_favoriteable_id", using: :btree
    t.index ["user_id", "favoriteable_id", "favoriteable_type"], name: "user_favoriteable_index", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_favorites_on_user_id", using: :btree
  end

  create_table "user_transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.uuid     "user_card_id"
    t.text     "description"
    t.integer  "transaction_id"
    t.decimal  "amount"
    t.string   "reason"
    t.string   "status"
    t.integer  "status_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["order_id"], name: "index_user_transactions_on_order_id", using: :btree
    t.index ["user_card_id"], name: "index_user_transactions_on_user_card_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name",                                   null: false
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_type",                       default: 0
    t.integer  "retailcrm_id"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.tsvector "full_name_and_phone_tsvector"
    t.integer  "orders_count",                    default: 0
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "referral_code"
    t.integer  "inviter_id"
    t.integer  "bonus_percent"
    t.integer  "bonus_amount"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["full_name_and_phone_tsvector"], name: "index_users_on_full_name_and_phone_tsvector", using: :gist
    t.index ["inviter_id"], name: "index_users_on_inviter_id", using: :btree
    t.index ["phone"], name: "index_users_on_phone", unique: true, using: :btree
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "shops"
  add_foreign_key "addresses", "users"
  add_foreign_key "bonuses", "orders"
  add_foreign_key "bonuses", "users"
  add_foreign_key "connections", "users", column: "salesman_id"
  add_foreign_key "connections", "users", column: "shop_id"
  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "users"
  add_foreign_key "product_filters", "filters"
  add_foreign_key "product_filters", "products"
  add_foreign_key "product_relationships", "products"
  add_foreign_key "products", "countries"
  add_foreign_key "schedule_intervals", "schedule_days"
  add_foreign_key "shops", "shop_categories"
  add_foreign_key "shops", "users"
  add_foreign_key "user_cards", "users"
  add_foreign_key "user_favorites", "users"
  add_foreign_key "user_transactions", "orders"
  add_foreign_key "users", "users", column: "inviter_id"
end
