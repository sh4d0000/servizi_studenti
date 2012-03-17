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

ActiveRecord::Schema.define(:version => 20120316151528) do

  create_table "keys", :force => true do |t|
    t.string   "P_1XXD"
    t.string   "P_2XXI"
    t.string   "P_3XXC"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "surname"
    t.string   "name"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.string   "citizenship"
    t.string   "tax_code"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "study_plans", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teachings", :force => true do |t|
    t.integer  "program_year"
    t.string   "name"
    t.string   "outcome"
    t.integer  "cfu"
    t.string   "taf"
    t.string   "ssd"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
