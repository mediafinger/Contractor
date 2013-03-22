require 'spec_helper'

describe Invoice do
  
  before :all do
    @user = User.create(name: "Micky", email: "michela@example.com")
    @customer =  Customer.create(name: "Willi", email: "wonker@example.com")
    @customer2 = Customer.create(name: "Bert",  email: "ernie@example.com")
    @address =  Address.create(owner_id: @customer.id,  owner_type: "Customer")
    @address2 = Address.create(owner_id: @customer2.id, owner_type: "Customer", tax_permill: 85)

    @product = Product.create(key: :it, unit_id: 1, price: 900, name: "just do it")
    @status_one = Status.create(key: :one, name: "ONE", sorting: 1)

    @p1 = Project.create(customer_id: @customer.id,  name: "pee one", status_id: @status_one.id)
    @p2 = Project.create(customer_id: @customer2.id, name: "pee too", status_id: @status_one.id)
    @line_item1 = LineItem.create(project: @p1, product: @product, quantity: 1000, modifier: -10)
    @line_item2 = LineItem.create(project: @p2, product: @product, quantity: 100)

    @i1 = Invoice.create(sent: 1.week.ago,  project_id: @p1.id, kind: :offer,   until: 1.week.from_now, user_id: @user.id, open: true,  accepted: false)
    @i2 = Invoice.create(sent: 2.weeks.ago, project_id: @p2.id, kind: :quote,   until: 4.days.ago,      user_id: @user.id, open: false, accepted: true)
    @i3 = Invoice.create(sent: 1.day.ago,   project_id: @p2.id, kind: :invoice, until: 1.day.from_now,  user_id: @user.id, open: true,  accepted: true)
  end

  after :all do
    Address.destroy_all
    Customer.destroy_all
    Invoice.destroy_all
    LineItem.destroy_all
    Product.destroy_all
    Project.destroy_all
    Status.destroy_all
    User.destroy_all
  end
    
  describe "creation" do    
    context "when attributes are valid" do
      it "builds a invoice" do
        invoice = Invoice.new(project_id: @p1.id, kind: :invoice, user_id: 1)
        invoice.valid?.should eq true
      end
    end

    context "when attributes are invalid" do
      it "does not save the invoice without a project_id" do
        invoice = Invoice.new(kind: :invoice, user_id: 1)
        invoice.valid?.should eq false
      end

      it "does not save the invoice without a kind" do
        invoice = Invoice.new(project_id: @p1.id, user_id: 1)
        invoice.valid?.should eq false
      end

      it "does not save the invoice when the given kind in none of the allowed" do
        invoice = Invoice.new(project_id: @p1.id, kind: "Rechnung", user_id: 1)
        invoice.valid?.should eq false
      end

      it "does not save the invoice without a user_id" do
        invoice = Invoice.new(project_id: @p1.id, kind: :invoice)
        invoice.valid?.should eq false
      end
    end
  end

  describe "scopes" do
    context "when retrieving all Invoices" do
      it "returns the Invoices by creation date" do
        Invoice.all.should == [@i1, @i2, @i3]
      end
    end

    context "when ordering by_date_sent" do
      it "returns the Invoices in ASC order" do
        Invoice.by_date_sent.should == [@i2, @i1, @i3]
      end
    end

    context "when ordering by_date_until" do
      it "returns the Invoices in ASC order" do
        Invoice.by_date_until.should == [@i2, @i3, @i1]
      end
    end

    context "when ordering by_customer name" do
      it "returns the Invoices in alphabetical order of Customer name" do
        Invoice.by_customer[2].should == @i1
      end
    end

    context "when filtering for kind" do
      it "returns only the Invoices of the given kind, e.g. :offer" do
        Invoice.is_of_kind(:offer).should == [@i1]
      end
      
      it "returns only the Invoices of the given kind, e.g. :quote" do
        Invoice.is_of_kind(:quote).should == [@i2]
      end

      it "returns only the Invoices of the given kind, e.g. :invoice" do
        Invoice.is_of_kind(:invoice).should == [@i3]
      end
    end

    context "when filtering for status" do
      it "returns only the Invoices in the given status, e.g. waiting" do
        Invoice.is_waiting.should == [@i1]
      end

      it "returns only the Invoices in the given status, e.g. closed" do
        Invoice.is_closed.should == []
      end

      it "returns only the Invoices in the given status, e.g. accepted" do
        Invoice.is_accepted.should == [@i3]
      end

      it "returns only the Invoices in the given status, e.g. archieved" do
        Invoice.is_archieved.should == [@i2]
      end
    end
  end

  describe "#open_invoices" do
    it "needs a Decorator"
  end

  describe "#total_price_with_taxes" do
    it "returns the total_price of the project including the taxes" do
      @i1.total_price_with_taxes.should == 8100.0
    end

    it "returns the total_price of the project including the taxes" do
      @i2.total_price_with_taxes.should == 976.5
    end
  end

  describe "#tax_modification" do
    it "returns 1 if tax_permill is not set in the Customer's Address" do
      @i1.tax_modification.should == 1.0
    end

    it "returns the factor to calculate the taxes if tax_permill is set in the Customer's Address" do
      @i3.tax_modification.should == 1.085
    end
  end

end