class AddEndDateColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :intro_ldrshp_team_end, :date
    add_column :events, :information_act_end, :date
    add_column :events, :info_calls_end, :date
    add_column :events, :special_event_calls_end, :date
    add_column :events, :celebration_wknd_calls_end, :date
    add_column :events, :ac_res_calls_end, :date
  end
end
