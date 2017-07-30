class Specialavailability < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :date, :open_time, :close_time
  validate :logical_times
  
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :between, -> (start, end_at) { where( [ "(date >= ?  AND  date <= ?) ",
    start, end_at])
  }
  
  def as_json(options = {})
    {
      :id => self.id,
      :title =>  self.is_available == true ? 'Available' : '',
      :description => "",
      :start => self.date.to_s + ' '  + self.open_time.strftime('%H:%M:00'),
      :end => self.date.to_s  + ' '  + self.close_time.strftime('%H:%M:00'),
      :allDay => false, 
      :recurring => false
      
    }
    
  end
  
  
  def logical_times
    if close_time <= open_time
      errors.add(:close_time, "can't be before starting time!")
    end
  end
  
  def open_datetime
    (date.to_s + " " + open_time.strftime("%H:%M")).to_datetime
  end

  def close_datetime
    (date.to_s + " " + close_time.strftime("%H:%M")).to_datetime
  end
  
end
