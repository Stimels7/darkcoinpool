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

ActiveRecord::Schema.define(:version => 20110623113222) do

  create_table "pool_worker", :force => true do |t|
    t.integer "associatedUserId",               :null => false
    t.string  "username",         :limit => 50
    t.string  "password"
  end

  create_table "shares", :force => true do |t|
    t.timestamp "time",                           :null => false
    t.string    "rem_host",                       :null => false
    t.string    "username",        :limit => 120, :null => false
    t.string    "our_result",      :limit => 0,   :null => false
    t.string    "upstream_result", :limit => 0
    t.string    "reason",          :limit => 50
    t.string    "solution",        :limit => 257, :null => false
  end

  create_table "test_dates", :force => true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
