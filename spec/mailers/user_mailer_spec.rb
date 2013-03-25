require "spec_helper"

describe UserMailer do
  describe "signup_confirmation" do
    let(:user) { User.create(name: "willi", email: "wonker@example.com") }
    let(:mail) { UserMailer.signup_confirmation(user) }

    it "renders the headers" do
      mail.subject.should eq("Signup confirmation")
      mail.to.should eq([user.email])
      mail.from.should eq(["info@onosono.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("UserMailer#signup_confirmation\r\nThanks for signing up to Contractor, #{user.name}!\r\n")
    end
  end

end
