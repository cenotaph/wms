class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :teacher, class_name: 'User', optional: true
  
  validates_presence_of :user_id
  scope :paid, -> () { where(fee_paid: true)}
  scope :teacher_approved, -> () { where(teacher_approved: true) }
  
  def in_future?
    if requested_start.nil? 
      return true
    else
      if requested_start > Time.current
        return true
      else
        return false
      end
    end
  end
  
end
