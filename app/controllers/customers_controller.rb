class CustomersController < BaseAuthenticationController
  respond_to :html

  # create, edit, index, new, show, update method inherited from BaseAuthenticationController


  private

    def create_params
      params.require(:customer).permit(:active, :email, :name)
    end

    def update_params
      params.require(:customer).permit(:active, :email, :name)
    end

end
