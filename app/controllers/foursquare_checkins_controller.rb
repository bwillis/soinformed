class FoursquareCheckinsController < ApplicationController

  skip_before_filter :ensure_authenticated_user
  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :verify_foursquare_push_secret, :only => :create

  def create
    # parsing
    checkin_data = ActiveSupport::JSON.decode(params['checkin'])
    checkin = SoInformed::Foursquare::Checkin.new(checkin_data)

    head :ok and return unless checkin.is_complete?

    # user lookup and contact retrieval
    user = User.find_by_uid(checkin.user_id)

    head :ok and return unless user.present?

    notifiable_contacts = user.contacts.notifiable.select { |c| c.should_notify?(checkin.shout) }
    contact_phone_numbers = notifiable_contacts.collect { |c| c.phone_number }
    head :ok and return if notifiable_contacts.empty?

    # build message
    sms_message = "#{checkin.username} checked-in at #{checkin.venue_name}"
    if checkin.has_address?
      case contact.location_display
        when :text
          sms_message << " #{checkin.address}"
        when :link
          sms_message << " http://#{Settings.base_url}/m/#{someid}"
      end
    end
    sms_message << " #{checkin.shout}" if checkin.has_shout?

    # notify contacts
    sms_worker = SoInformed::SmsWorker.new
    sms_worker.process(sms_message, contact_phone_numbers)
    # mark contacts as messaged
    notifiable_contacts.each { |contact| contact.mark_notified! }

    head :ok
  end

  private

  def verify_foursquare_push_secret
    if params[:secret] != Settings.app_push_secret
      render :file => "public/401.html", :status => :unauthorized and return
    end
  end
end