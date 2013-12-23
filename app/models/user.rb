class User < ActiveRecord::Base
  
  scope :admin, -> {where(admin: 'true')}
  
  before_save {email.downcase!}
  after_destroy :ensure_an_admin_remains
  
  has_secure_password
  
  validates_presence_of :password, :on => :create
  validates :email, presence: true, format: /.+@.+\..+/i, uniqueness: true, length: { within: 5..50}
  
  #validates_presence_of :email, :on => :create
  #validates_length_of :email, :within => 5..50
  
  has_many :campaigns
  has_many :events, :through => :campaigns
  
  def name
    first_name + " " + last_name
  end
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete the last user!!"
    end
  end
end
