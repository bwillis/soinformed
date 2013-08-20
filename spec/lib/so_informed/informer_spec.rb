require "spec_helper"

describe SoInformed::Informer do
  before do
    @user = User.create(:name => "test", :uid => "test")
    @contact_a = @user.contacts.create(:name => "A", :phone_number => "1111111111", :notify_state => :always)
    @contact_b = @user.contacts.create(:name => "B", :phone_number => "2222222222", :notify_state => :only_mention)
    @contact_c = @user.contacts.create(:name => "C", :phone_number => "3333333333", :notify_state => :never)

    @checkin = SoInformed::Foursquare::CheckinData.object(@user.uid, "Hey #B what's up?")

    @informer = SoInformed::Informer.new(@checkin)
  end

  context "initialize" do
    it "has 2 notifiable contacts" do
      @informer.notifiable_contacts.length.should == 2
    end
  end

  context "notify_all" do
    before do
      @sms_client = double("FakeSmsClient")
      @sms_client.stub(:process)
      SoInformed::Sms::ClientFactory.stub(:get_client).and_return(@sms_client)

      @foursquare_client = double("FakeFoursquareClient")
      @foursquare_client.stub(:post)
      SoInformed::Foursquare::ClientFactory.stub(:get_client).and_return(@foursquare_client)
    end

    it "should notify two contacts via sms" do
      @sms_client.should_receive(:process).with("Jimmy Foursquare checked-in at foursquare HQ (East Village) Hey #B what's up? Reply to comment", ["1111111111","2222222222"])
      @informer.notify_all
    end

    it "should post to foursquare" do
      @foursquare_client.should_receive(:post)
      @informer.notify_all
    end

    it "should mark the contacts as notified" do
      Timecop.freeze(Time.now) do
        @informer.notify_all
        @contact_a.reload; @contact_b.reload

        @contact_a.last_checkin_id.should == @checkin.id
        @contact_a.last_message_at.should == Time.now

        @contact_b.last_checkin_id.should == @checkin.id
        @contact_b.last_message_at.should == Time.now
      end
    end

    it "should not mark the non-notified contact as notified" do
      @contact_c.reload
      @contact_c.last_checkin_id.should be_nil
      @contact_c.last_message_at.should be_nil
    end
  end
end