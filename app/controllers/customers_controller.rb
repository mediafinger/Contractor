class CustomersController < ApplicationController
  respond_to :html

  def index
    @customers = Customer.all
    respond_with @customers
  end

  def show
    @customer = Customer.find(params[:id])
    respond_with @customer
  end

  def new
    @customer = Customer.new
    respond_with @customer
  end

  def edit
    @customer = Customer.find(params[:id])
    respond_with @customer
  end

  def create
    @customer = Customer.new(customer_params)
    flash[:notice] = 'Customer was successfully created.' if @customer.save
    respond_with @customer
  end

  def update
    @customer = Customer.find(params[:id])
    flash[:notice] = 'Customer was successfully updated.' if @customer.update_attributes(customer_params)
    respond_with @customer
  end

  def destroy
    @customer = Customer.find(params[:id])
    flash[:notice] = 'Customer was successfully deleted.' if @customer.destroy
    respond_with @customer
  end


  private

    def customer_params
      params.require(:customer).permit(:active, :email, :name)
    end
end
