require 'spec_helper'

describe Product do

  before :all do
    @p1z = Product.create(key: "pZ", price: 19.95, unit_id: 1)
    @p2a = Product.create(key: "pA", price: 19.95, unit_id: 1)
  end
    
  after :all do
    Product.destroy_all
  end

  describe "creation" do    
    context "when attributes are valid" do
      it "builds a product" do
        product = Product.new(key: "p1", price: 19.95, unit_id: 1)
        product.valid?.should eq true
      end
    end

    context "when attributes are invalid" do
      it "does not save the product without a key" do
        product = Product.new(price: 19.95, unit_id: 1)
        product.valid?.should eq false
      end

      it "does not save the product without a price" do
        product = Product.new(key: "p1", unit_id: 1)
        product.valid?.should eq false
      end

      it "does not save the product without an unit_id" do
        product = Product.new(key: "p1", price: 19.95)
        product.valid?.should eq false
      end

      it "does not save the product when price is not numerical" do
        product = Product.new(key: "p1", price: "nine.fifty", unit_id: 1)
        product.valid?.should eq false
      end

      it "does not save the product when key exist already" do
        Product.create(key: "my_key", price: 19.95, unit_id: 1)

        product = Product.new(key: "my_key", price: 9.99, unit_id: 1)
        product.valid?.should eq false
      end
    end
  end

  describe "scopes" do
    context "when retrieving all Products" do
      it "returns the Products by creation date" do
        Product.all.should == [@p1z, @p2a]
      end
    end

    context "when ordering by_key" do
      it "returns the Products in alphabetical order" do
        Product.by_key.should == [@p2a, @p1z]
      end
    end
  end

end