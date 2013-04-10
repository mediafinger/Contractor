# Customer-Specs:

# Given there are no Customers
# When I create one
# Then this Customer will be saved

# Given there are Customers
# When I create another one
# And use an unique Email address
# Then this Customer will be saved

# Given there are Customers
# When I create another one
# And use an existing Email address
# Then I will receive an error message

# Given I display the list of Customers
# When I search for a Customer
# Then I will find him in alphabetical order


require "spec_helper"

describe CustomersController do
  before :all do
    @user = User.create(name: "Andy", email: "admin@example.com")
  end

  after :all do
    Customer.destroy_all
    User.destroy_all
  end

  before :each do 
    sign_in @user
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.code.to_i).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    # it "loads all of the customers into @customers" do
    #   customer1, customer2 = Customer.create!, Customer.create!
    #   get :index

    #   expect(assigns(:customers)).to match_array([customer1, customer2])
    # end
  end

  describe "POST #create" do
    it "creates a customer" do
      expect {
        post :create, :customer => {name: "Willi", email: "willi@wonker.com"}
      }.to change(Customer, :count).by(1)
    end
  end

end

# TODO:

# Product-Specs:

# Given the App was just installed
# When I want to create a Product
# Then I can choose of a set of Units

# Given there are no Products
# When I create one
# And all validations pass
# Then this Product will be saved

# *Given there are Products
# When I edit one
# Then I am not allowed to edit the Key and the Unit

# Given I display the list of Products
# When I search for a Product
# Then I will find it in alphabetical order of it's Key


# Project-Specs:

# Given the App was just installed
# When I want to create a Project
# Then I can choose of a set of Statuses

# *Given there are Projects
# When I edit one
# Then I am not allowed to edit the Customer

# Given I edit a Project
# When I want to add a LineItem
# Then I can choose of all the Products
# And I can set the Quantity
# And I can set a modifier between -100 and 100

# Given I show a Project with LineItems
# When I check the TotalPrice
# Then it is the sum of the LineItem Prices
