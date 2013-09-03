require "spec_helper"

describe SoInformed::SmsInformer do
  before do
    @user = User.create(:name => "Ben", :token => "bens-token", :uid => "test")
    @contact = @user.contacts.create(
        :name            => "Joe",
        :phone_number    => "2345678901",
        :last_message_at => Time.now,
        :last_checkin_id => "abc-123-def-456"
    )

    @text_message = "Text message from abc"
    @sms = SoInformed::Sms::Sms.new("+12345678901", @text_message)
    @informer = SoInformed::SmsInformer.new(@sms)
  end

  context "notify_all" do
    it "should notify the user via checkin reply" do
      SoInformed::Foursquare::MockClient.any_instance.should_receive(:post).with do |url, params|
        url.should == "checkins/#{@contact.last_checkin_id}/addpost"
        params[:text].should == "#{@contact.name} commented: #{@text_message}"
        true
      end
      @informer.notify_all
    end

    context "when the same number is for multiple contacts" do
      before do
        @other_user = User.create(:name => "Joe", :token => "joes-token", :uid => "test")
        @other_user.contacts.create(
            :name            => "Big Joe",
            :phone_number    => "2345678901",
            :last_message_at => 5.days.ago,
            :last_checkin_id => "xyz-098-tuv-765"
        )
      end

      it "notifies the user who checked in last" do
        SoInformed::Foursquare::ClientFactory.should_receive(:get_client).with("bens-token").and_call_original
        @informer.notify_all
      end
    end
  end
end
