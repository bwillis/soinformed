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

ActiveRecord::Schema.define(:version => 20130808073654) do

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "notify_state",         :default => "never"
    t.datetime "notify_state_updated"
    t.integer  "user_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "location_display",     :default => "text"
  end

  create_table "phone_numbers", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.string   "number",                        :null => false
    t.boolean  "disabled",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "phone_number_1"
    t.string   "name"
  end

end
