require 'spec_helper'

describe LineItem do
  
  before :all do
    @customer = Customer.create(name: "Willi", email: "wonker@example.com")

    @project1 = Project.create(customer_id: @customer.id, name: "p1", status_id: 1)
    @project2 = Project.create(customer_id: @customer.id, name: "p2", status_id: 1)

    @product1 = Product.create(key: "zz", price: 19.95, unit_id: 1)
    @product2 = Product.create(key: "aa", price: 50.00, unit_id: 1)

    @l1 = LineItem.create(product_id: @product1.id, project_id: @project1.id, quantity: 5, modifier: 0)
    @l2 = LineItem.create(product_id: @product2.id, project_id: @project2.id, quantity: 50, modifier: 10)
  end

  after :all do
    Customer.destroy_all
    Product.destroy_all
    Project.destroy_all
    LineItem.destroy_all
  end
    
  describe "creation" do    
    context "when attributes are valid" do
      it "builds a line_item" do
        line_item = LineItem.new(product_id: 1, project_id: 1, quantity: 50)
        line_item.valid?.should eq true
      end

      it "builds a line_item with a modifier up to 100" do
        line_item = LineItem.new(product_id: 1, project_id: 1, quantity: 50, modifier: 100)
        line_item.valid?.should eq true
      end

      it "builds a line_item with a modifier down to -100" do
        line_item = LineItem.new(product_id: 1, project_id: 1, quantity: 50, modifier: -100)
        line_item.valid?.should eq true
      end
    end

    context "when attributes are invalid" do
      it "does not save the line_item without a product_id" do
        line_item = LineItem.new(project_id: 1, quantity: 50)
        line_item.valid?.should eq false
      end

      it "does not save the line_item without a project_id" do
        line_item = LineItem.new(product_id: 1, quantity: 50)
        line_item.valid?.should eq false
      end

      it "does not save the line_item without a quantity" do
        line_item = LineItem.new(product_id: 1, project_id: 1)
        line_item.valid?.should eq false
      end

      it "does not save the line_item when quantity is not numerical" do
        line_item = LineItem.new(product_id: 1, project_id: 1, quantity: "FittyCents")
        line_item.valid?.should eq false
      end

      it "does not save the line_item when the given modifier is not numerical" do
        line_item = LineItem.new(product_id: 1, project_id: 1, quantity: 50, modifier: "more")
        line_item.valid?.should eq false
      end

      it "does not save the line_item when the given modifier is not an integer" do
        line_item = LineItem.new(product_id: 1, project_id: 1, quantity: 50, modifier: 1.5)
        line_item.valid?.should eq false
      end

      it "does not save the line_item when the given modifier is not in the range" do
        line_item = LineItem.new(product_id: 1, project_id: 1, quantity: 50, modifier: 9999)
        line_item.valid?.should eq false
      end
    end
  end

  describe "scopes" do
    context "when retrieving all LineItems" do
      it "returns the LineItems by creation date" do
        LineItem.all.should == [@l1, @l2]
      end
    end

    context "when ordering by_name" do
      it "returns the LineItems in alphabetical order of the products" do
        LineItem.by_product.should == [@l2, @l1]
      end
    end

    context "when filtering in_project" do
      it "returns only the LineItems in the given Project" do
        LineItem.in_project(@project1).should == [@l1]
      end
    end
  end

  describe "#price" do
    it "returns the LineItems price in EUR including the modification" do
      @l2.price.should == 27.50
    end
  end

  describe "#modification" do
    it "returns the modifier as a modificational factor" do
      @l2.modification.should == 1.1
    end
  end

  describe "#discounted?" do
    it "returns true if the modifier is a negative number" do
      line_item = LineItem.new(product_id: @product1.id, project_id: @project1.id, quantity: 5, modifier: -20)
      line_item.discounted?.should == true
    end

    it "returns false if the modifier is not a negative number" do
      (@l1.discounted? || @l2.discounted?).should_not == true
    end
  end

  describe "#normal_priced?" do
    it "returns true if the modifier is 0" do
      @l1.normal_priced?.should == true
    end

    it "returns false if the modifier is not 0" do
      @l2.normal_priced?.should == false
    end
  end
  
  describe "#surcharged?" do
    it "returns true if the modifier is a positive number" do
      @l2.surcharged?.should == true
    end

    it "returns false if the modifier is not a positive number" do
      @l1.surcharged?.should == false
    end
  end

end