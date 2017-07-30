class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :teacher, class_name: 'User', optional: true
  
  validates_presence_of :user_id
  scope :paid, -> () { where(fee_paid: true)}
  scope :teacher_approved, -> () { where(teacher_approved: true) }
  
end
