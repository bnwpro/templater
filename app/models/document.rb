class Document
  
  attr_reader :resp_doc, :manual_titles_en, :first_two_only
  
  def resp_doc
    @resp_doc = ["ac_resp", "cadmin_resp", "chair_resp", "childs_act_resp", "contact_resp", "event_resp",
      "follow_resp", "info_resp", "involve_resp", "pacesetter_resp", "pastor_resp", "prayer_resp", "print_resp",
      "visual_resp", "youth_resp"]
  end
  
  def manual_titles_en
    @manual_titles_en = ["Advance Commitment Leader Guide", "Campaign Administrator Guide", "Campaign Chair Guide", "Children Activity Leader Guide",
      "Contact Leader Guide", "Event Leader Guide", "Follow Up Leader Guide", "Information Leader Guide", "Involvement Leader Guide", "Pacesetter Leader Guide",
      "Pastor Guide", "Prayer Leader Guide", "Print Leader Guide", "Visual Communications Leader Guide", "Youth Leader Guide"]
  end
  
  def manual_common_pages_en
    @manual_common_pages_en = ["pdfs/templates/intro_pages/1_cover.pdf", "pdfs/templates/intro_pages/2_index_contact.pdf",
      "pdfs/templates/intro_pages/3_upto_gift_profile.pdf", "pdfs/templates/intro_pages/4_gift_profile_chart.pdf",
      "pdfs/templates/intro_pages/5_upto_enlist_1.pdf", "pdfs/templates/intro_pages/6_enlist_2.pdf",
      "pdfs/templates/intro_pages/7_upto_involvement.pdf"]
  end
  
  def worksheets_en
    @worksheets_en = ["pdfs/templates/addendums/AC1-en.pdf", "pdfs/templates/addendums/AC2-en.pdf", "pdfs/templates/addendums/AC3-en.pdf",
      "pdfs/templates/addendums/CT1-en.pdf", "pdfs/templates/addendums/CT2-en.pdf", "pdfs/templates/addendums/CT3-en.pdf", "pdfs/templates/addendums/CT4-en.pdf",
      "pdfs/templates/addendums/CT5-en.pdf", "pdfs/templates/addendums/CT6-en.pdf", "pdfs/templates/addendums/CT7-en.pdf",
      "pdfs/templates/addendums/IN1-en.pdf", "pdfs/templates/addendums/IN2-en.pdf"]
  end
  
  def temp
    @first_two_only = ["prayer_resp", "visual_resp"]
  end
end
