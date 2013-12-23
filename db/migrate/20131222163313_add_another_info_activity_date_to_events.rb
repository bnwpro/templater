class AddAnotherInfoActivityDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :information_act_2_dates, :date
    add_column :events, :information_act_2_end, :date
  end
end
