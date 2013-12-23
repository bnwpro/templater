class Document
  
  attr_reader :resp_doc, :manual_titles_en, :first_two_only
  
  def self.resp_doc
    @resp_doc = ["ac_resp", "cadmin_resp", "chair_resp", "childs_act_resp", "contact_resp", "event_resp",
      "follow_resp", "info_resp", "involve_resp", "pacesetter_resp", "pastor_resp", "prayer_resp", "print_resp",
      "visual_resp", "youth_resp"]
  end
  
  def self.manual_titles_en
    @manual_titles_en = ["Advance Commitment Leader Guide", "Campaign Administrator Guide", "Campaign Chair Guide", "Children Activity Leader Guide",
      "Contact Leader Guide", "Event Leader Guide", "Follow Up Leader Guide", "Information Leader Guide", "Involvement Leader Guide", "Pacesetter Leader Guide",
      "Pastor Guide", "Prayer Leader Guide", "Print Leader Guide", "Visual Communications Leader Guide", "Youth Leader Guide"]
  end
  
  def self.first_two_only
    @first_two_only = ["ac_resp", "cadmin_resp"]
  end
end
