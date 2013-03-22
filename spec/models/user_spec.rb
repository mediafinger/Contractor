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
        User.create(name: "Willi", email: "willi@wonker.com")

        user = User.new(name: "Wonker", email: "willi@wonker.com")
        user.valid?.should eq false
      end
    end
  end

  describe "scopes" do
    context "when retrieving all Users" do
      it "returns the Users by creation date" do
        User.all.should == [@u1, @u2]
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

end