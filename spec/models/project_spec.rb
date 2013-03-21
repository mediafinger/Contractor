require 'spec_helper'

describe Project do
  
  before :all do
    @customer = Customer.create(name: "Willi", email: "wonker@example.com")
    @customer2 = Customer.create(name: "Zett", email: "zett@example.com")

    @status_one = Status.create(key: :one, name: "ONE", sorting: 1)
    @status_two = Status.create(key: :two, name: "TWO", sorting: 2)

    @p1z_c2 = Project.create(customer_id: @customer2.id, name: "z_c2", status_id: @status_one.id)
    @p2a_c1 = Project.create(customer_id: @customer.id,  name: "a_c1", status_id: @status_two.id)
  end

  after :all do
    Customer.destroy_all
    Project.destroy_all
    Status.destroy_all
  end
    
  describe "creation" do    
    context "when attributes are valid" do
      it "builds a project" do
        project = Project.new(customer_id: @customer.id, name: "p1", status_id: 1)
        project.valid?.should eq true
      end
    end

    context "when attributes are invalid" do
      it "does not save the project without a customer_id" do
        project = Project.new(name: "p1", status_id: 1)
        project.valid?.should eq false
      end

      it "does not save the project when the given customer does not exist" do
        project = Project.new(customer_id: 657567, name: "p1", status_id: 1)
        project.valid?.should eq false
      end

      it "does not save the project without a name" do
        project = Project.new(customer_id: @customer.id, status_id: 1)
        project.valid?.should eq false
      end

      it "does not save the project without a status" do
        project = Project.new(customer_id: @customer.id, name: "p1")
        project.valid?.should eq false
      end
    end
  end

  describe "scopes" do
    context "when retrieving all Projects" do
      it "returns the Projects by creation date" do
        Project.all.should == [@p1z_c2, @p2a_c1]
      end
    end

    context "when ordering by_name" do
      it "returns the Projects in alphabetical order" do
        Project.by_name.should == [@p2a_c1, @p1z_c2]
      end
    end

    context "when ordering by_customer name" do
      it "returns the Projects in alphabetical order of Customer name" do
        Project.by_customer.should == [@p2a_c1, @p1z_c2]
      end
    end

    context "when ordering by_status" do
      it "returns the Projects in order of their statuses" do
        Project.by_status.should == [@p1z_c2, @p2a_c1]
      end
    end

    context "when filtering in_status" do
      it "returns only the Projects in the given status" do
        Project.in_status(@status_one).should == [@p1z_c2]
      end
    end
  end

  describe "#line_items_sorted_by_product_unit" do
    it "needs line items - and a Product Fabricator"
  end


  describe "#total_price" do
    it "needs line items - and a Product Fabricator"
  end

  describe "#is_active?" do
    it "should be a testable method - not such temporarily crap"
  end

end