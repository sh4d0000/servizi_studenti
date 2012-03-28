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

ActiveRecord::Schema.define(:version => 20120325211800) do

  create_table "exam_bookings", :force => true do |t|
    t.string   "teaching"
    t.date     "date"
    t.time     "time"
    t.string   "classroom"
    t.string   "professor"
    t.integer  "booking_number"
    t.text     "notes"
    t.string   "delete_prenotation_url"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "exam_sessions", :force => true do |t|
    t.string   "teaching"
    t.string   "course"
    t.string   "address"
    t.integer  "cfu"
    t.string   "ssd"
    t.date     "date"
    t.string   "prenotation_range"
    t.string   "classroom"
    t.string   "professor"
    t.text     "notes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.time     "time"
    t.string   "prenotation_url"
  end

  create_table "exams", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.string   "code"
    t.string   "outcome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "isees", :force => true do |t|
    t.string   "student_code"
    t.string   "name"
    t.string   "surname"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.string   "tax_code"
    t.float    "value_scale_equivalence"
    t.float    "ise"
    t.float    "isee"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "caf_protocol_number"
  end

  create_table "keys", :force => true do |t|
    t.string   "P_1XXD"
    t.string   "P_2XXI"
    t.string   "P_3XXC"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments", :force => true do |t|
    t.string   "code"
    t.string   "academic_year"
    t.text     "description"
    t.float    "amount"
    t.date     "date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "status"
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
