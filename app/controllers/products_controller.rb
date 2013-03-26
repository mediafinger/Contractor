class ProductsController < BaseAuthenticationController
  respond_to :html

  before_filter :get_units, :only => [:new, :create, :edit, :update]

  # create, edit, index, new, show, update method inherited from BaseAuthenticationController


  private

    def get_units
      @units = Unit.by_name
    end

    def create_params
      params.require(:product).permit(:active, :key, :name, :price, :unit_id)
    end

    def update_params
      params.require(:product).permit(:active, :name, :price)
    end
end
