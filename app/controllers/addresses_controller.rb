class AddressesController < ApplicationController
  respond_to :html

  def index
    @addresses = Address.all
    respond_with @addresses
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    if params[:owner_id] && params[:owner_type]
      klass = params[:owner_type].constantize
      @owners = [ klass.find_by_id(params[:owner_id]) ]
    else
      klass = (params[:owner_type] && params[:owner_type].constantize) || User
      get_owners(klass)
    end

    if @owners.empty?
      flash[:error] = 'Keine neuen Addressen erforderlich.'
      redirect_to action: :index
    end

    @address = Address.new
  end

  def create
    get_owners(params[:address][:owner_type].constantize)

    @address = Address.new(address_params)
    flash[:notice] = 'Address was successfully created.' if @address.save
    respond_with @address
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    flash[:notice] = 'Address was successfully updated.' if @address.update_attributes(address_params)
    respond_with @address
  end

  
  private

    # Only get those Users OR Customers that do not have an Address yet
    def get_owners(klass)
      @owners = klass.is_active.by_name.select { |o| !o.address }
    end

    def address_params
      params.require(:address)
    end

end