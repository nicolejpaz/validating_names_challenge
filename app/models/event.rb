class Event < ActiveRecord::Base
  validate :date_is_invalid
  validate :event_cannot_be_in_the_past
  validates_uniqueness_of :title, message: "title is already taken"
  validates :title, uniqueness: true
  validates :title, presence: true
  validates :organizer_name, presence: true
  validate :email_is_valid

  def date_is_invalid
    if date.nil?
      errors.add(:date, "was not selected")
    end
  end

  def email_is_valid
    if organizer_email.match(/\S{2,}@{1}\S{2,}.{1}\S{2,}/).nil?
      errors.add(:email, "is invalid")
    end
  end

  def event_date_is_present
    if date.nil?
      errors.add(:date, "is required")
      p errors.messages
    end
  end

  def event_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "cannot be in the past")
    end
  end
end
