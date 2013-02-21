class CustomersController < ApplicationController
  respond_to :html, :json

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
    @customer = Customer.new(params[:customer])
    flash[:notice] = 'Customer was successfully created.' if @customer.save
    respond_with @customer
  end

  def update
    @customer = Customer.find(params[:id])
    flash[:notice] = 'Customer was successfully updated.' if @customer.update_attributes(params[:customer])
    respond_with @customer
  end

  def destroy
    @customer = Customer.find(params[:id])
    flash[:notice] = 'Customer was successfully deleted.' if @customer.destroy
    respond_with @customer
  end
end
