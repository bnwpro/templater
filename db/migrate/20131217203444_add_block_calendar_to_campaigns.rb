class AddBlockCalendarToCampaigns < ActiveRecord::Migration
  def self.up
    add_attachment :campaigns, :block_calendar
  end

  def self.down
    remove_attachment :campaigns, :block_calendar
  end
end
