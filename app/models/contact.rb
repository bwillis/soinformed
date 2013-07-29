class Contact < ActiveRecord::Base

  attr_accessible :name, :notify_state, :phone_number

  belongs_to :user

  NOTIFY_STATES = [:never, :only_mention, :"6_hours", :always]

  symbolize :notify_state, :in => NOTIFY_STATES, :scopes => true
  validates_presence_of :name, :phone_number

  before_save :update_notify_state_time, :if => :notify_state_changed?

  scope :notifiable, lambda { where("notify_state != ?", :never) }

  def should_notify?(checkin_message=nil)
    case notify_state
      when :never
        false
      when :only_mention
        return false unless checkin_message
        checkin_message =~ checkin_name
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

  def checkin_name
    "##{name}"
  end

  private

    def update_notify_state_time
      self.notify_state_updated = Time.now
    end
end
