class Campaign < ActiveRecord::Base
  #has_attached_file :block_calendar, :url => "pdfs/campaign_docs/:id/block_calendar.pdf",
  #  :path => ":rails_root/pdfs/campaign_docs/:id/block_calendar.pdf"
  has_attached_file :block_calendar,
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    :storage => :s3,
    :s3_protocol => 'https',
    :s3_permissions => :public_read,
    :bucket => 'ofwc_bc_directory',
    :url => ':s3_path_url',
    :path => 'block_calendar_cid_:id.pdf',
    :copy_to_local_file => "pdfs/campaign_docs/:id/block_calendar.pdf"
  validates_attachment :block_calendar, content_type: { content_type: "application/pdf" }
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: /.+@.+\..+/i, length: { within: 5..50}, allow_blank: true
  validates :city, presence: true
  validates :phone, :fax, numericality: true, allow_blank: true
  validates :zip, numericality: { only_integer: true }, length: { within: 5..10 }, allow_blank: true
  validates_associated :campaign_contacts
  #attr_accessor :block_calendar
  
  belongs_to :user
  
  has_many :sql_templates, :dependent => :destroy
  
  has_many :campaign_contacts, :dependent => :destroy
  accepts_nested_attributes_for :campaign_contacts, :allow_destroy => true
  has_one :event, :dependent => :destroy
  accepts_nested_attributes_for :event
  has_one :training_sheet, :dependent => :destroy
  accepts_nested_attributes_for :training_sheet
  has_one :enlistment, :dependent => :destroy
  accepts_nested_attributes_for :enlistment
  has_one :gift_profile, :dependent => :destroy
  accepts_nested_attributes_for :gift_profile
  
  def multiply(num)
    num * 2
  end
  
end