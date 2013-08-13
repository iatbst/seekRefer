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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130812224605) do

  create_table "china_cities", force: true do |t|
    t.string   "province"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "china_colleges", force: true do |t|
    t.string   "province"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "connect_requests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.boolean  "accepted"
    t.integer  "from_id"
    t.integer  "to_id"
  end

  add_index "connect_requests", ["from_id"], name: "index_connect_requests_on_from_id", using: :btree
  add_index "connect_requests", ["to_id"], name: "index_connect_requests_on_to_id", using: :btree

  create_table "connects", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from_id"
    t.integer  "to_id"
  end

  add_index "connects", ["from_id"], name: "index_connects_on_from_id", using: :btree
  add_index "connects", ["to_id"], name: "index_connects_on_to_id", using: :btree

  create_table "follow_rules", force: true do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "industry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "follower_id"
  end

  add_index "follow_rules", ["company_id"], name: "index_follow_rules_on_company_id", using: :btree
  add_index "follow_rules", ["follower_id"], name: "index_follow_rules_on_follower_id", using: :btree
  add_index "follow_rules", ["industry_id"], name: "index_follow_rules_on_industry_id", using: :btree
  add_index "follow_rules", ["location_id"], name: "index_follow_rules_on_location_id", using: :btree

  create_table "industries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_posts", force: true do |t|
    t.integer  "industry_id"
    t.integer  "company_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poster_id"
    t.text     "content"
    t.integer  "position_id"
  end

  add_index "job_posts", ["company_id"], name: "index_job_posts_on_company_id", using: :btree
  add_index "job_posts", ["industry_id"], name: "index_job_posts_on_industry_id", using: :btree
  add_index "job_posts", ["location_id"], name: "index_job_posts_on_location_id", using: :btree
  add_index "job_posts", ["position_id"], name: "index_job_posts_on_position_id", using: :btree
  add_index "job_posts", ["poster_id"], name: "index_job_posts_on_poster_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "refer_cases", force: true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "referrer_id"
    t.integer  "referral_id"
    t.boolean  "is_active"
    t.string   "result"
    t.integer  "feedback"
  end

  add_index "refer_cases", ["referral_id"], name: "index_refer_cases_on_referral_id", using: :btree
  add_index "refer_cases", ["referrer_id"], name: "index_refer_cases_on_referrer_id", using: :btree

  create_table "refer_posts", force: true do |t|
    t.integer  "refer_case_id"
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refer_posts", ["refer_case_id"], name: "index_refer_posts_on_refer_case_id", using: :btree
  add_index "refer_posts", ["user_id"], name: "index_refer_posts_on_user_id", using: :btree

  create_table "refer_requests", force: true do |t|
    t.string   "token"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from_id"
    t.integer  "to_id"
  end

  add_index "refer_requests", ["from_id"], name: "index_refer_requests_on_from_id", using: :btree
  add_index "refer_requests", ["to_id"], name: "index_refer_requests_on_to_id", using: :btree

  create_table "us_colleges", force: true do |t|
    t.string   "state"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "dept"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "hometown_id"
    t.integer  "china_school1_id"
    t.integer  "china_school2_id"
    t.integer  "us_school1_id"
    t.integer  "us_school2_id"
  end

  add_index "users", ["china_school1_id"], name: "index_users_on_china_school1_id", using: :btree
  add_index "users", ["china_school2_id"], name: "index_users_on_china_school2_id", using: :btree
  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["hometown_id"], name: "index_users_on_hometown_id", using: :btree
  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["us_school1_id"], name: "index_users_on_us_school1_id", using: :btree
  add_index "users", ["us_school2_id"], name: "index_users_on_us_school2_id", using: :btree

end
