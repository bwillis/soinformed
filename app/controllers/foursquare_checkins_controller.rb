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
    contact_phone_numbers_with_text_message = []
    contact_phone_numbers_with_link_message = []
    notifiable_contacts.each do |contact|
      case contact.location_display
        when :link
          contact_phone_numbers_with_link_message << contact.phone_number
        when :text
          contact_phone_numbers_with_text_message << contact.phone_number
      end
    end
    head :ok and return if notifiable_contacts.empty?

    # build message
    base_sms_message = "#{checkin.username} checked-in at #{checkin.venue_name}"
    if checkin.has_address?
      text_address_message = "#{base_sms_message} #{checkin.address}"
      link_address_message = "#{base_sms_message} http://google.com/m/123"
    end
    text_address_message << " #{checkin.shout}" if checkin.has_shout?
    link_address_message << " #{checkin.shout}" if checkin.has_shout?

    # notify contacts
    sms_client = SoInformed::Sms::ClientFactory.get_client
    sms_client.process(text_address_message, contact_phone_numbers_with_text_message)
    sms_client.process(link_address_message, contact_phone_numbers_with_link_message)

    # mark contacts as messaged
    notifiable_contacts.each { |contact| contact.mark_notified! }

    head :ok
  end

  private

  def verify_foursquare_push_secret
    if params[:secret] != Settings.app_push_secret && !Rails.env.development?
      Rails.logger.warn("Invalid foursquare push secret request.")
      render :file => "public/401.html", :status => :unauthorized and return
    end
  end
end