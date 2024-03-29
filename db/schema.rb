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

ActiveRecord::Schema.define(:version => 20130530040936) do

  create_table "attendees", :force => true do |t|
    t.integer  "outing_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  add_index "attendees", ["outing_id"], :name => "index_attendees_on_outing_id"

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "poster_large"
    t.string   "poster_med"
    t.integer  "runtime"
    t.string   "mpaa_rating"
    t.integer  "critics_score",  :default => 0
    t.integer  "audience_score", :default => 0
    t.string   "poster"
    t.text     "synopsis"
  end

  add_index "movies", ["title"], :name => "index_movies_on_title", :unique => true

  create_table "outings", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "link"
    t.datetime "result_date"
  end

  add_index "outings", ["user_id"], :name => "index_outings_on_user_id"

  create_table "selecteds", :force => true do |t|
    t.integer "attendee_id"
    t.integer "selection_id"
  end

  create_table "selections", :force => true do |t|
    t.integer  "showtime_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "movie_id"
    t.integer  "theater_id"
    t.datetime "time"
    t.integer  "outing_id"
    t.integer  "selected_count", :default => 0
  end

  create_table "showtimes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "time"
    t.integer  "movie_id"
    t.integer  "theater_id"
  end

  add_index "showtimes", ["movie_id", "theater_id", "time"], :name => "index_showtimes_on_movie_id_and_theater_id_and_time", :unique => true

  create_table "theaters", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "cache_date"
    t.string   "street"
    t.string   "city"
    t.string   "state"
  end

  add_index "theaters", ["street", "name", "city", "state", "phone_number"], :name => "uniqueness_index", :unique => true

  create_table "theaters_zipcodes", :force => true do |t|
    t.integer  "zipcode_id"
    t.integer  "theater_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "theaters_zipcodes", ["zipcode_id", "theater_id"], :name => "index_theaters_zipcodes_on_zipcode_id_and_theater_id", :unique => true
  add_index "theaters_zipcodes", ["zipcode_id"], :name => "index_theaters_zipcodes_on_zipcode_id"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "image"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "admin",            :default => false, :null => false
  end

  create_table "zipcodes", :force => true do |t|
    t.string   "zipcode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "cache_date"
  end

end
