require "spec_helper"

describe Contact do
  context "phone_number=" do
    it "reformats with a 10 digit phone number" do
      contact = Contact.new(:name => "test", :phone_number => "123-123-1234")
      expect(contact).to be_valid
    end
    it "reformats with a 11 digit phone number with a leading 1" do
      contact = Contact.new(:name => "test", :phone_number => "1-123-123-1234")
      expect(contact).to be_valid
    end
  end
end