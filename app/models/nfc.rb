class Nfc < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :tag_address

  scope :by_user, ->(user_id) { where(user_id: user_id) }
end
