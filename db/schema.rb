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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121229002621) do

  create_table "addresses", :force => true do |t|
    t.string   "bank_account_number"
    t.string   "bank_name"
    t.string   "bank_number"
    t.string   "city"
    t.string   "company_name"
    t.string   "country"
    t.text     "description"
    t.string   "email"
    t.string   "fax"
    t.string   "fon"
    t.string   "foto"
    t.string   "language"
    t.string   "mobile"
    t.string   "name"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "region"
    t.string   "street"
    t.string   "tax_permill"
    t.string   "tax_number"
    t.string   "website"
    t.string   "zip"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "addresses", ["owner_id"], :name => "index_addresses_on_owner_id"
  add_index "addresses", ["owner_type"], :name => "index_addresses_on_owner_type"

  create_table "customers", :force => true do |t|
    t.boolean  "active",     :default => true
    t.date     "birthday"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true

  create_table "invoices", :force => true do |t|
    t.boolean  "accepted",   :default => false
    t.string   "kind"
    t.boolean  "open",       :default => true
    t.integer  "project_id"
    t.date     "sent"
    t.date     "until"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "invoices", ["kind"], :name => "index_invoices_on_kind"
  add_index "invoices", ["project_id"], :name => "index_invoices_on_project_id"
  add_index "invoices", ["until"], :name => "index_invoices_on_until"
  add_index "invoices", ["user_id"], :name => "index_invoices_on_user_id"

  create_table "line_items", :force => true do |t|
    t.integer "modifier",                                  :default => 0
    t.integer "product_id"
    t.integer "project_id"
    t.decimal "quantity",   :precision => 10, :scale => 3
  end

  add_index "line_items", ["product_id"], :name => "index_line_items_on_product_id"
  add_index "line_items", ["project_id"], :name => "index_line_items_on_project_id"

  create_table "products", :force => true do |t|
    t.boolean  "active",                                   :default => true
    t.string   "key"
    t.string   "name"
    t.decimal  "price",      :precision => 9, :scale => 2
    t.string   "unit_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  add_index "products", ["key"], :name => "index_products_on_key", :unique => true

  create_table "project_logs", :force => true do |t|
    t.string   "action"
    t.text     "params"
    t.integer  "project_id"
    t.integer  "line_item_id"
    t.integer  "status_change"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "project_logs", ["project_id"], :name => "index_project_logs_on_project_id"

  create_table "projects", :force => true do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.date     "paid"
    t.integer  "status_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "projects", ["customer_id"], :name => "index_projects_on_customer_id"
  add_index "projects", ["status_id"], :name => "index_projects_on_status_id"

  create_table "statuses", :force => true do |t|
    t.string  "key"
    t.string  "name"
    t.integer "sorting"
  end

  add_index "statuses", ["key"], :name => "index_statuses_on_key", :unique => true

  create_table "units", :force => true do |t|
    t.boolean "active", :default => true
    t.boolean "float",  :default => true
    t.string  "key"
    t.string  "name"
    t.string  "plural"
  end

  add_index "units", ["key"], :name => "index_units_on_key", :unique => true

  create_table "users", :force => true do |t|
    t.boolean  "active",               :default => true
    t.boolean  "admin",                :default => false
    t.date     "birthday"
    t.string   "email"
    t.string   "name"
    t.string   "authentication_token"
    t.datetime "remember_created_at"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
