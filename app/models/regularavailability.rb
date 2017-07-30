class Regularavailability < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :day_of_week, :open_time, :close_time
  validate :logical_times
  
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_dayofweek, ->(day_of_week) { where(day_of_week: day_of_week) }
  
  
  def self.between(start_at, end_at)
    slots = []
    (start_at..end_at).to_a.each do |day|
      begin
        unless self.by_dayofweek(day.to_date.wday).nil?
          self.by_dayofweek(day.to_date.wday).each do |slot|
            slots << Specialavailability.new(user_id: slot.user_id, date: day, open_time: slot.open_time, close_time: slot.close_time, is_available: true)
          end
        end
      rescue
        next
      end
    end
    return slots
  end
  
  def logical_times
    if close_time <= open_time
      errors.add(:close_time, "can't be before starting time!")
    end
  end
  
  
end
