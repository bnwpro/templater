class CreateTrainingSheets < ActiveRecord::Migration
  def change
    create_table :training_sheets do |t|
      t.integer :campaign_id
      t.string :print_contact_name
      t.string :print_contact_phone
      t.string :print_contact_email
      t.integer :man_ac, default: 1
      t.integer :man_camp_admin, default: 1
      t.integer :man_camp_chair, default: 1
      t.integer :man_childs_act, default: 1
      t.integer :man_contact, default: 1
      t.integer :man_follow_up, default: 1
      t.integer :man_info, default: 1
      t.integer :man_invlvm, default: 1
      t.integer :man_pace_gifts, default: 1
      t.integer :man_prayer, default: 1
      t.integer :man_print_comm, default: 1
      t.integer :man_spc_event, default: 1
      t.integer :man_vis_comm, default: 1
      t.integer :man_youth, default: 1
      t.integer :man_pastor, default: 1
      t.integer :ts_ac1, default: 1
      t.integer :ts_ac2, default: 1
      t.integer :ts_ac3, default: 1
      t.integer :ts_ct1, default: 1
      t.integer :ts_ct2, default: 1
      t.integer :ts_ct3, default: 1
      t.integer :ts_ct4, default: 1
      t.integer :ts_ct5, default: 1
      t.integer :ts_ct6, default: 1
      t.integer :ts_ct7, default: 1
      t.integer :ts_it1, default: 1
      t.integer :ts_it2, default: 1
      t.index :campaign_id

      t.timestamps
    end
  end
end
