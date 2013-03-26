class AddressesController < BaseAuthenticationController
  respond_to :html

  # edit, index, show, update method inherited from BaseAuthenticationController


  def new
    klass = (params[:owner_type] && params[:owner_type].constantize) || User

    if params[:owner_id]
      @owners = [ klass.find_by_id(params[:owner_id]) ]
    else
      get_owners(klass)
    end

    if @owners.empty?
      flash[:error] = 'Keine neuen Addressen erforderlich.'
      redirect_to action: :index
    else
      @address = Address.new
    end
  end

  def create
    get_owners(params[:address][:owner_type].constantize)

    @address = Address.new(create_params)
    flash[:notice] = 'Address was successfully created.' if @address.save
    respond_with @address
  end

  
  private

    # Only get those Users OR Customers that do not have an Address yet
    def get_owners(klass)
      @owners = klass.is_active.by_name.select { |o| !o.address }
    end

    def create_params
      params.require(:address)
    end

    def update_params
      params.require(:address)
    end
end