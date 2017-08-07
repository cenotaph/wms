class User < ApplicationRecord
  rolify
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable
         
  has_many :authentications, dependent: :destroy
  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update
  validates_uniqueness_of :email
  extend FriendlyId
  friendly_id :username , use: [ :slugged, :finders, :history]
  mount_uploader :avatar, ImageUploader
  before_save :update_avatar_attributes
  mount_uploader :cv, FileUploader
  before_save :update_cv_attributes
  has_and_belongs_to_many :genres
  accepts_nested_attributes_for :genres
  has_many :images, as: :item, dependent: :destroy
  validates_length_of :images, maximum: 2
  accepts_nested_attributes_for :images, reject_if: proc{|att| att['image'].blank? }
  has_and_belongs_to_many :languages
  accepts_nested_attributes_for :languages, reject_if: proc{|att| att == "0" || att.blank? }
  has_and_belongs_to_many :teachinglevels
  accepts_nested_attributes_for :teachinglevels, reject_if: proc{|att| att == "0" || att.blank? }
  has_and_belongs_to_many :teachinglocations
  accepts_nested_attributes_for :teachinglocations, reject_if: proc{|att| att == "0" || att.blank? }
  belongs_to :howdidfind, optional: true

  scope :approved_teachers, -> () {where(approved_teacher: true)}
  has_many :regularavailabilities
  has_many :specialavailabilities
  has_many :bookings
  has_many :registrations, class_name: 'Booking', foreign_key: :teacher_id
  
  def availability
    [regularavailabilities, specialavailabilities].flatten.compact
  end
  
  
 
  
  def has_applied?
    applied_as_teacher || applied_as_student
  end
  
  def apply_omniauth(omniauth)
    if omniauth['provider'] == 'twitter'
      logger.warn(omniauth.inspect)
      self.username = omniauth['info']['nickname']
      self.name = omniauth['info']['name']
      self.name.strip!
      identifier = self.username

    elsif omniauth['provider'] == 'facebook'
      self.email = omniauth['info']['email'] if email.blank? || email =~ /change@me/
      self.username = omniauth['info']['name']
      self.name = omniauth['info']['name'] 
      self.name.strip!
      identifier = self.username
      # self.location = omniauth['extra']['user_hash']['location']['name'] if location.blank?
    
    elsif omniauth['provider'] == 'google_oauth2'
      self.email = omniauth['info']['email'] 
      self.name = omniauth['info']['name']
      self.username = omniauth['info']['email'].gsub(/\@gmail\.com/, '')
      identifier = self.username
    end
    if email.blank?
      if omniauth['info']['email'].blank?
        self.email = "#{TEMP_EMAIL_PREFIX}-#{omniauth['uid']}-#{omniauth['provider']}.com"
      else
        self.email = omniauth['info']['email']
      end
    end
    
    self.password = SecureRandom.hex(32) if password.blank?  # generate random password to satisfy validations
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :username => identifier)
  end
  
  protected
  
  def update_avatar_attributes
    if avatar.present? && avatar_changed?
      if avatar.file.exists?
        self.avatar_content_type = avatar.file.content_type
        self.avatar_size = avatar.file.size
        self.avatar_width, self.avatar_height = `identify -format "%wx%h" #{avatar.file.path}`.split(/x/)
      end
    end
  end

  def update_cv_attributes
    if cv.present? && cv_changed?
      if cv.file.exists?
        self.cv_content_type = cv.file.content_type
        self.cv_size = cv.file.size
      end
    end
  end
    
end
