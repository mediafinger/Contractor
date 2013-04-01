class AddressesController < BaseAuthenticationController
  respond_to :html

  # edit, index, show, update method inherited from BaseAuthenticationController


  def new
    klass = (params[:owner_type] && params[:owner_type].constantize) || User
    get_possible_owners(klass)
    
    if @owners.empty?
      flash[:error] = 'Keine neuen Addressen erforderlich.'
      redirect_to action: :index
    else
      @address = Address.new
    end
  end

  def create
    get_possible_owners(params[:address][:owner_type].constantize)

    @address = Address.new(create_params)
    flash[:notice] = 'Address was successfully created.' if @address.save
    respond_with @address
  end

  
  private

    # Only get those Users OR Customers that do not have an Address yet
    def get_possible_owners(klass)
      if params[:owner_id]
        @owners = [ get_owner(klass, params[:owner_id]) ]
      else
        @owners = klass.is_active.by_name.select { |o| !o.address }
      end
    end

    def get_owner(klass, id)
      klass.find_by_id(id)
    end

    def create_params
      params.require(:address)
    end

    def update_params
      params.require(:address)
    end
end