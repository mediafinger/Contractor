require 'spec_helper'

describe Customer do

  before :all do
    @c1z = Customer.create(name: "Zett", email: "zet@example.com", active: false)
    @c2a = Customer.create(name: "Alpha", email: "alpha@example.com", active: true)
  end

  after :all do
    Customer.destroy_all
  end

  describe "creation" do    
    context "when attributes are valid" do
      it "builds a customer" do
        customer = Customer.new(name: "Willi", email: "willi@wonker.com")
        customer.valid?.should eq true
      end
    end

    context "when attributes are invalid" do
      it "does not save the customer without a name" do
        customer = Customer.new(email: "willi@wonker.com")
        customer.valid?.should eq false
      end

      it "does not save the customer without an email" do
        customer = Customer.new(name: "Willi")
        customer.valid?.should eq false
      end

      it "does not save the customer when email exist already" do
        Customer.create(name: "Willi", email: "willi@wonker.com")

        customer = Customer.new(name: "Wonker", email: "willi@wonker.com")
        customer.valid?.should eq false
      end
    end
  end

  describe "scopes" do
    context "when retrieving all Customers" do
      it "returns the Customers by creation date" do
        Customer.all.should == [@c1z, @c2a]
      end
    end

    context "when ordering by_name" do
      it "returns the Customers in alphabetical order" do
        Customer.by_name.should == [@c2a, @c1z]
      end
    end

    context "when filtering for active Customers" do
      it "returns only active Customers" do
        Customer.is_active.should == [@c2a]
      end
    end

    context "when filtering for archived Customers" do
      it "returns only inactive Customers" do
        Customer.is_archived.should == [@c1z]
      end
    end
  end

end