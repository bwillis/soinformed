class Contact < ActiveRecord::Base

  attr_accessible :name, :notify_state, :phone_number, :location_display

  belongs_to :user

  NOTIFY_STATES = [:never, :only_mention, :"6_hours", :always]
  LOCATION_DISPLAYS = [:text, :link, :none]
  LOCATION_DISPLAY_EXAMPLES = {:text => "123 Main St btw 1st and 2nd Ave", :link => "http://"}

  symbolize :notify_state, :in => NOTIFY_STATES, :scopes => true
  symbolize :location_display, :in => LOCATION_DISPLAYS

  validates_presence_of :name, :phone_number
  validate :check_and_format_phone_number

  before_save :update_notify_state_time, :if => :notify_state_changed?

  scope :notifiable, lambda { where("notify_state != ?", :never) }

  def phone_number=(num)
    num.gsub!(/\D/, '') if num.is_a?(String)
    super(num)
  end

  def should_notify?(checkin_message=nil)
    case notify_state
      when :never
        false
      when :only_mention
        return false unless checkin_message
        checkin_message.downcase.include?("##{name}".downcase) || checkin_message.downcase.include?("@#{name}".downcase)
      when :always
        true
      when :"6_hours"
        (notify_state_updated + 06.hours).future?
      else
        false
    end
  end

  def notify_state=(val)
    update_notify_state_time
    super(val)
  end

  def mark_notified!
    increment(:message_count)
    self.last_message_at = Time.now
    save
  end

  private

  def update_notify_state_time
    self.notify_state_updated = Time.now
  end

  def check_and_format_phone_number
    if self.phone_number.length != 10
      self.errors.add(:phone_number, "can only be 10 digits")
    end
  end
end
