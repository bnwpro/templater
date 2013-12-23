json.array!(@training_sheets) do |training_sheet|
  json.extract! training_sheet, :campaign_id, :print_contact_name, :print_contact_phone, :print_contact_email, :man_ac, :man_camp_admin, :man_camp_chair, :man_childs_act, :man_contact, :man_follow_up, :man_info, :man_invlvm, :man_pace_gifts, :man_prayer, :man_print_comm, :man_spc_event, :man_vis_comm, :man_youth, :man_pastor, :ts_ac1, :ts_ac2, :ts_ac3, :ts_ct1, :ts_ct2, :ts_ct3, :ts_ct4, :ts_ct5, :ts_ct6, :ts_ct7, :ts_it1, :ts_it2
  json.url training_sheet_url(training_sheet, format: :json)
end
