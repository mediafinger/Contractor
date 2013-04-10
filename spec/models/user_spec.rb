require 'spec_helper'

describe User do

  before :all do
    @u1 = User.create(name: "Zett", email: "zet@example.com", active: false)
    @u2 = User.create(name: "Alpha", email: "alpha@example.com", active: true)
  end

  after :all do
    User.destroy_all
  end

  describe "creation" do    
    context "when attributes are valid" do
      it "builds a user" do
        user = User.new(name: "Willi", email: "willi@wonker.com")
        user.valid?.should eq true
      end
    end

    context "when attributes are invalid" do
      it "does not save the user without a name" do
        user = User.new(email: "willi@wonker.com")
        user.valid?.should eq false
      end

      it "does not save the user without an email" do
        user = User.new(name: "Willi")
        user.valid?.should eq false
      end

      it "does not save the user when email exist already" do
        willi = User.create(name: "Willi", email: "willi@wonker.com")

        user = User.new(name: "Wonker", email: "willi@wonker.com")
        user.valid?.should eq false
        willi.destroy.should eq willi
      end
    end
  end

  describe "scopes" do
    context "when retrieving all Users" do
      it "returns the Users by creation date" do
        User.all.order('created_at ASC').should == [@u1, @u2]
      end
    end

    context "when ordering by_name" do
      it "returns the Users in alphabetical order" do
        User.by_name.should == [@u2, @u1]
      end
    end

    context "when filtering for active Users" do
      it "returns only active Users" do
        User.is_active.should == [@u2]
      end
    end

    context "when filtering for archived Users" do
      it "returns only inactive Users" do
        User.is_archived.should == [@u1]
      end
    end
  end

  describe "#activate!" do
    context "when calling on an inactive user" do
      after :each do
        @u1.update_attributes(active: false)
      end

      it "activates the user" do
        @u1.activate!.active.should == true
      end

      it "sends an email including an login token" do
        @u1.should_receive(:ensure_authentication_token)
        @u1.should_receive(:send_activation_confirmation_mail)

        @u1.activate!
      end

      it "returns self even when something breaks" do
        @u1.stub!(:save!).and_return(false)

        @u1.should_not_receive(:send_activation_confirmation_mail)
        @u1.activate!.should == @u1
      end
    end

    context "when calling on an active user" do
      it "does not send an email" do
        @u2.should_not_receive(:ensure_authentication_token)
        @u2.should_not_receive(:send_activation_confirmation_mail)

        @u2.activate!
      end
    end
  end

end