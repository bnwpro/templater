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

ActiveRecord::Schema.define(version: 20140109162210) do

  create_table "campaign_contacts", force: true do |t|
    t.integer  "campaign_id"
    t.string   "description"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaign_contacts", ["campaign_id"], name: "index_campaign_contacts_on_campaign_id"

  create_table "campaigns", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "diocese"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "url"
    t.integer  "number_of_families",                                   default: 0
    t.decimal  "contribution_income",         precision: 14, scale: 2
    t.boolean  "has_pacesetter",                                       default: true
    t.boolean  "standalone",                                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "block_calendar_file_name"
    t.string   "block_calendar_content_type"
    t.integer  "block_calendar_file_size"
    t.datetime "block_calendar_updated_at"
  end

  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id"

  create_table "enlistments", force: true do |t|
    t.integer  "campaign_id"
    t.integer  "ac_enlist",           default: 0
    t.integer  "childs_act_enlist",   default: 0
    t.integer  "spc_event_enlist",    default: 0
    t.integer  "contact_enlist",      default: 0
    t.integer  "contact_each_enlist", default: 0
    t.integer  "info_enlist",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enlistments", ["campaign_id"], name: "index_enlistments_on_campaign_id"

  create_table "events", force: true do |t|
    t.datetime "date"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "leadership_team_trng"
    t.datetime "campaign_admin_trng"
    t.datetime "involvement_ldr_trng"
    t.datetime "pastor_cmp_mtg_1"
    t.datetime "prayer_ldr_trng"
    t.datetime "print_vis_comm_mtg_1"
    t.datetime "event_ldr_trng"
    t.datetime "childrens_act_ldr_trng"
    t.datetime "contact_ldr_trng"
    t.datetime "info_ldr_trng"
    t.datetime "youth_act_ldr_cons_mtg"
    t.datetime "ac_mtg_1"
    t.datetime "pacesetter_gift_pln_mtg_1"
    t.date     "intro_ldrshp_team_dates"
    t.datetime "leadership_team_rpt_mtg_1"
    t.datetime "pastor_cmp_mtg_2"
    t.datetime "print_vis_comm_mtg_2"
    t.datetime "contact_team_asst_trng_1"
    t.datetime "contact_team_asst_trng_2"
    t.datetime "ac_mtg_2"
    t.datetime "pacesetter_gift_pln_mtg_2"
    t.datetime "leadership_team_rpt_mtg_2"
    t.datetime "pastor_cmp_mtg_3"
    t.datetime "contact_team_trng_1"
    t.datetime "contact_team_trng_2"
    t.datetime "contact_team_trng_3"
    t.datetime "info_team_trng_1"
    t.datetime "info_team_trng_2"
    t.datetime "ac_mtg_3"
    t.datetime "pacesetter_gift_pln_mtg_3"
    t.datetime "leadership_team_rpt_mtg_3"
    t.datetime "follow_up_mtg"
    t.datetime "ac_host_orient"
    t.datetime "commit_wknd_mtg_pas_cons"
    t.datetime "pacesetter_gift_rpt_mtg"
    t.datetime "leadership_team_rpt_mtg_4"
    t.date     "information_act_dates"
    t.date     "weekend_1_dates"
    t.date     "weekend_2_dates"
    t.datetime "ac_gather_1"
    t.datetime "ac_gather_2"
    t.datetime "ac_gather_3"
    t.datetime "ac_gather_4"
    t.date     "youth_invlvm_wknd_dates"
    t.date     "youth_commt_event"
    t.date     "weekend_3_dates"
    t.date     "weekend_4_dates"
    t.date     "parish_wide_event_dates"
    t.date     "celebration_mass_dates"
    t.date     "mail_fact_sheet"
    t.date     "mail_rmng_info_pkts"
    t.date     "mail_ac_invt"
    t.date     "mail_newsletter"
    t.date     "mail_spc_event_invt"
    t.date     "mail_commt_card"
    t.date     "setup_info_booth"
    t.date     "info_calls_dates"
    t.date     "special_event_calls_dates"
    t.date     "celebration_wknd_calls_dates"
    t.date     "ac_res_calls_dates"
    t.date     "intro_ldrshp_team_end"
    t.date     "information_act_end"
    t.date     "info_calls_end"
    t.date     "special_event_calls_end"
    t.date     "celebration_wknd_calls_end"
    t.date     "ac_res_calls_end"
    t.date     "information_act_2_dates"
    t.date     "information_act_2_end"
  end

  add_index "events", ["campaign_id"], name: "index_events_on_campaign_id"

  create_table "gift_profiles", force: true do |t|
    t.integer  "campaign_id"
    t.decimal  "goal",             precision: 9, scale: 0, default: 0
    t.integer  "t1_gifts_1",                               default: 0
    t.integer  "t1_gifts_2",                               default: 0
    t.integer  "t1_gifts_3",                               default: 0
    t.integer  "t1_gifts_4",                               default: 0
    t.integer  "t1_gifts_5",                               default: 0
    t.integer  "t1_gifts_6",                               default: 0
    t.decimal  "t1_gift_amount_1", precision: 7, scale: 0, default: 0
    t.decimal  "t1_gift_amount_2", precision: 7, scale: 0, default: 0
    t.decimal  "t1_gift_amount_3", precision: 7, scale: 0, default: 0
    t.decimal  "t1_gift_amount_4", precision: 7, scale: 0, default: 0
    t.decimal  "t1_gift_amount_5", precision: 7, scale: 0, default: 0
    t.decimal  "t1_gift_amount_6", precision: 7, scale: 0, default: 0
    t.integer  "t2_gifts_1",                               default: 0
    t.integer  "t2_gifts_2",                               default: 0
    t.integer  "t2_gifts_3",                               default: 0
    t.integer  "t2_gifts_4",                               default: 0
    t.integer  "t2_gifts_5",                               default: 0
    t.integer  "t2_gifts_6",                               default: 0
    t.integer  "t2_gifts_7",                               default: 0
    t.decimal  "t2_gift_amount_1", precision: 7, scale: 0, default: 0
    t.decimal  "t2_gift_amount_2", precision: 7, scale: 0, default: 0
    t.decimal  "t2_gift_amount_3", precision: 7, scale: 0, default: 0
    t.decimal  "t2_gift_amount_4", precision: 7, scale: 0, default: 0
    t.decimal  "t2_gift_amount_5", precision: 7, scale: 0, default: 0
    t.decimal  "t2_gift_amount_6", precision: 7, scale: 0, default: 0
    t.decimal  "t2_gift_amount_7", precision: 7, scale: 0, default: 0
    t.integer  "t3_gifts_1",                               default: 0
    t.integer  "t3_gifts_2",                               default: 0
    t.integer  "t3_gifts_3",                               default: 0
    t.integer  "t3_gifts_4",                               default: 0
    t.integer  "t3_gifts_5",                               default: 0
    t.integer  "t3_gifts_6",                               default: 0
    t.decimal  "t3_gift_amount_1", precision: 7, scale: 0, default: 0
    t.decimal  "t3_gift_amount_2", precision: 7, scale: 0, default: 0
    t.decimal  "t3_gift_amount_3", precision: 7, scale: 0, default: 0
    t.decimal  "t3_gift_amount_4", precision: 7, scale: 0, default: 0
    t.decimal  "t3_gift_amount_5", precision: 7, scale: 0, default: 0
    t.decimal  "t3_gift_amount_6", precision: 7, scale: 0, default: 0
    t.decimal  "remainder",        precision: 7, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gift_profiles", ["campaign_id"], name: "index_gift_profiles_on_campaign_id"

  create_table "mercury_images", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sql_templates", force: true do |t|
    t.text     "body"
    t.string   "path"
    t.string   "format"
    t.string   "locale"
    t.string   "handler"
    t.boolean  "partial",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
  end

  add_index "sql_templates", ["campaign_id"], name: "index_sql_templates_on_campaign_id"

  create_table "training_sheets", force: true do |t|
    t.integer  "campaign_id"
    t.string   "print_contact_name"
    t.string   "print_contact_phone"
    t.string   "print_contact_email"
    t.integer  "man_ac",              default: 1
    t.integer  "man_camp_admin",      default: 1
    t.integer  "man_camp_chair",      default: 1
    t.integer  "man_childs_act",      default: 1
    t.integer  "man_contact",         default: 1
    t.integer  "man_follow_up",       default: 1
    t.integer  "man_info",            default: 1
    t.integer  "man_invlvm",          default: 1
    t.integer  "man_pace_gifts",      default: 1
    t.integer  "man_prayer",          default: 1
    t.integer  "man_print_comm",      default: 1
    t.integer  "man_spc_event",       default: 1
    t.integer  "man_vis_comm",        default: 1
    t.integer  "man_youth",           default: 1
    t.integer  "man_pastor",          default: 1
    t.integer  "ts_ac1",              default: 1
    t.integer  "ts_ac2",              default: 1
    t.integer  "ts_ac3",              default: 1
    t.integer  "ts_ct1",              default: 1
    t.integer  "ts_ct2",              default: 1
    t.integer  "ts_ct3",              default: 1
    t.integer  "ts_ct4",              default: 1
    t.integer  "ts_ct5",              default: 1
    t.integer  "ts_ct6",              default: 1
    t.integer  "ts_ct7",              default: 1
    t.integer  "ts_it1",              default: 1
    t.integer  "ts_it2",              default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "training_sheets", ["campaign_id"], name: "index_training_sheets_on_campaign_id"

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.string   "phone"
  end

end
