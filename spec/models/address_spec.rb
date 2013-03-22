require 'spec_helper'

describe Address do

  describe "creation" do    
    context "when attributes are valid" do
      it "builds a address" do
        address = Address.new(owner_id: 1, owner_type: "User")
        address.valid?.should eq true
      end
    end

    context "when attributes are invalid" do
      it "does not save the address without a owner_id" do
        address = Address.new(owner_type: "User")
        address.valid?.should eq false
      end

      it "does not save the address without an owner_type" do
        address = Address.new(owner_id: 1)
        address.valid?.should eq false
      end
    end
  end


end